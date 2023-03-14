const amqplib = require('amqplib');
const crypto = require('crypto');

const RMQConnectionString = process.env.RABBITMQ_CONNECTION_STRING;
const RPCQueueName = process.env.RABBITMQ_RPC_QUEUE_NAME;

// RabbitMQ connections and channels are meant to be long lived
let connection;
let channel;

function postApplication(applicantForm) {
    // We use the same callback queue for every request
    // for this client, so we identify requests by UUID
    var correlationId = crypto.randomUUID();

    return new Promise(async (resolve, reject) => {
        try {
            if (!channel) {
                connection = await amqplib.connect(RMQConnectionString);
                channel = await connection.createChannel();
            }
            q = await channel.assertQueue('', { exclusive: true });
            // TODO: prevent 406 PRECONDITION_FAILED - delivery acknowledgement timed out
            channel.consume(q.queue, (msg) => {
                if (msg.properties.correlationId == correlationId) {
                    // correlationId matched, so this is our request
                    
                    // TODO: do some stuff with the msg, could be an error
                    resolve(msg.content.toString());
                }
            });

            const sendToQProp = {
                correlationId: correlationId,
                replyTo: q.queue
            }

            channel.sendToQueue(
                RPCQueueName,
                Buffer.from(JSON.stringify(applicantForm)),
                sendToQProp);
        
        } catch (error) {
            reject(error);
        }
    });
}

module.exports = {
    postApplication
}