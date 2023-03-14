const amqplib = require('amqplib');

const RMQConnectionString = process.env.RABBITMQ_CONNECTION_STRING;
const RPCQueueName = process.env.RABBITMQ_RPC_QUEUE_NAME;

// RabbitMQ connections and channels are meant to be long lived
let connection;
let channel;

async function bootstrap() {
    try {
        if (!channel) {
            connection = await amqplib.connect(RMQConnectionString);
            channel = await connection.createChannel();
        }
        channel.assertQueue(RPCQueueName);
        channel.prefetch(1);    // We will only send out up to 1 msg on the consumer below
        channel.consume(RPCQueueName, function reply(msg) {

            // PLACEHOLDER: Validate and save applicant form
            var reply = `Hello ${ JSON.parse(msg.content.toString()).data }!`;
            
            channel.sendToQueue(
                msg.properties.replyTo,
                Buffer.from(reply),
                {
                    correlationId: msg.properties.correlationId
                }
            );
            channel.ack(msg);
        });
    } catch (error) {
        console.error(error);
    }
}
 
bootstrap();
