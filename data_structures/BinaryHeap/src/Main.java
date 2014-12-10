import java.util.Random;

public class Main {
	
	public static void main(String[] args) {
		java.util.PriorityQueue<Behaelter> pq = new java.util.PriorityQueue<Behaelter>();
		
		double timestamp = System.currentTimeMillis();
		Random rand = new Random();
		
		for(int i = 0; i < 3000000; i++) {
			pq.add(new Behaelter(rand.nextDouble(), i));
		}
		
		while(pq.isEmpty() == false) {
			pq.poll();
		}
		
		System.out.println("Dauer der Operationen " + ((System.currentTimeMillis() - timestamp)/1000) + "s");
	}
	
}