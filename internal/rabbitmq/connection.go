package rabbitmq

import (
	"log"
	"time"

	amqp "github.com/rabbitmq/amqp091-go"
)

type Connection struct {
	conn    *amqp.Connection
	channel *amqp.Channel
	url     string
}

func NewConnection(url string) (*Connection, error) {
	c := &Connection{url: url}
	if err := c.connect(); err != nil {
		return nil, err
	}
	return c, nil
}

func (c *Connection) connect() error {
	var err error
	for i := 0; i < 10; i++ {
		c.conn, err = amqp.Dial(c.url)
		if err == nil {
			break
		}
		log.Printf("RabbitMQ connect attempt %d failed: %v", i+1, err)
		time.Sleep(time.Duration(i+1) * time.Second)
	}
	if err != nil {
		return err
	}

	c.channel, err = c.conn.Channel()
	if err != nil {
		return err
	}

	// Declare the shared topic exchange
	err = c.channel.ExchangeDeclare("sx", "topic", true, false, false, false, nil)
	if err != nil {
		return err
	}

	log.Printf("Connected to RabbitMQ: %s", c.url)
	return nil
}

func (c *Connection) Channel() *amqp.Channel {
	return c.channel
}

func (c *Connection) Close() {
	if c.channel != nil {
		c.channel.Close()
	}
	if c.conn != nil {
		c.conn.Close()
	}
}
