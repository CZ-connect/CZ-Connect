const amqplib = require('amqplib');

const applicantFormController = require('./controllers/applicant_form_controller');

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

            // We reply OK or ERR back to the client indicating
            // if the validation and persisting of the form data
            // went well.
            var statusCode = applicantFormController
                    .validateAndSaveFormData(msg.content.toString())
                
            channel.sendToQueue(
                msg.properties.replyTo,
                Buffer.from(statusCode),
                {
                    correlationId: msg.properties.correlationId
                }
            );
            channel.ack(msg);
        });
    } catch (error) {
        console.error(error);
        throw(error);
    }
}
 
bootstrap();
