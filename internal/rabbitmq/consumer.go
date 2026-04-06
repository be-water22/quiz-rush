package rabbitmq

import (
	"context"
	"log"

	amqp "github.com/rabbitmq/amqp091-go"
)

type MessageHandler func(ctx context.Context, body []byte) error

type Consumer struct {
	conn      *Connection
	queueName string
	handler   MessageHandler
}

func NewConsumer(conn *Connection, queueName, routingKey string, handler MessageHandler) (*Consumer, error) {
	ch := conn.Channel()

	// Declare the queue
	_, err := ch.QueueDeclare(queueName, true, false, false, false, amqp.Table{
		"x-dead-letter-exchange":    "",
		"x-dead-letter-routing-key": queueName + "-dlq",
	})
	if err != nil {
		return nil, err
	}

	// Declare the DLQ
	_, err = ch.QueueDeclare(queueName+"-dlq", true, false, false, false, nil)
	if err != nil {
		return nil, err
	}

	// Bind queue to exchange
	err = ch.QueueBind(queueName, routingKey, "sx", false, nil)
	if err != nil {
		return nil, err
	}

	// Set prefetch
	err = ch.Qos(10, 0, false)
	if err != nil {
		return nil, err
	}

	return &Consumer{
		conn:      conn,
		queueName: queueName,
		handler:   handler,
	}, nil
}

func (c *Consumer) Start(ctx context.Context) error {
	msgs, err := c.conn.Channel().Consume(c.queueName, "", false, false, false, false, nil)
	if err != nil {
		return err
	}

	log.Printf("Consumer started for queue: %s", c.queueName)

	go func() {
		for {
			select {
			case <-ctx.Done():
				return
			case msg, ok := <-msgs:
				if !ok {
					return
				}
				if err := c.handler(ctx, msg.Body); err != nil {
					log.Printf("Error processing message from %s: %v", c.queueName, err)
					msg.Nack(false, false) // Send to DLQ
				} else {
					msg.Ack(false)
				}
			}
		}
	}()

	return nil
}
