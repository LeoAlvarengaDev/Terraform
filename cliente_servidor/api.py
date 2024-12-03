from flask import Flask, request, jsonify
from kafka import KafkaProducer, KafkaConsumer

app = Flask(__name__)

producer = KafkaProducer(bootstrap_servers='kafka-broker:9092')

@app.route('/send', methods=['POST'])
def send_message():
    data = request.json
    topic = data.get('topic')
    message = data.get('message')

    producer.send(topic, value=message.encode())
    return jsonify({"status": "message sent"}), 200

@app.route('/consume', methods=['GET'])
def consume_message():
    topic = request.args.get('topic')
    consumer = KafkaConsumer(topic, bootstrap_servers='kafka-broker:9092')

    messages = []
    for msg in consumer:
        messages.append(msg.value.decode())
        if len(messages) > 10:  # Limitar a leitura
            break

    return jsonify(messages), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
