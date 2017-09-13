import java.io.DataInputStream;
import java.io.FileInputStream;

import javax.jms.Connection;
import javax.jms.DeliveryMode;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.jms.Topic;

import org.apache.activemq.ActiveMQConnectionFactory;

public class ExampleXmlPublisher {

	public static void main(String[] args) {

		try {

			ActiveMQConnectionFactory connectionFactory = new ActiveMQConnectionFactory("tcp://Marcin-Komputer:61616");

			Connection connection = connectionFactory.createConnection();
			connection.start();

			Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

			Topic topic = session.createTopic("Example.Library.Publication");

			MessageProducer producer = session.createProducer(topic);
			producer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);

			FileInputStream fs = new FileInputStream("excercise-1.xml");
			DataInputStream in = new DataInputStream(fs);
			byte[] buf = new byte[in.available()];
			in.readFully(buf);
			in.close();
			String text = new String(buf);

			TextMessage message = session.createTextMessage(text);

			System.out.println("Sent message:\n\n" + text);

			producer.send(message);

			session.close();
			connection.close();

		} catch (Exception e) {
			System.out.println("Caught: " + e);
			e.printStackTrace();
		}

	}

}
