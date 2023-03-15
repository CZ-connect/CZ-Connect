const amqplib = require('amqplib');
const crypto = require('crypto');

const RMQConnectionString = process.env.RABBITMQ_CONNECTION_STRING;
const RPCQueueName = process.env.RABBITMQ_RPC_QUEUE_NAME;

// RabbitMQ connections and channels are meant to be long lived
let connection;
let channel;

function postApplication(applicantForm) {
    return new Promise(async (resolve, reject) => {
        try {
            if (!channel) {
                connection = await amqplib.connect(RMQConnectionString);
                channel = await connection.createChannel();
            }
            channel.sendToQueue(
                RPCQueueName,
                Buffer.from(JSON.stringify(applicantForm)));
            resolve();
        } catch (error) {
            reject(error);
        }
    });
}

module.exports = {
    postApplication
}