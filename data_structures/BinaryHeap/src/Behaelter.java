
public class Behaelter implements java.lang.Comparable{
	
	private double prio;
	private int value;
	
	public Behaelter(double prio, int value){
		this.prio = prio;
		this.value = value;
	}

	@Override
	public int compareTo(Object arg0) {
		Behaelter other = (Behaelter) arg0;
		if(prio < other.prio)
			return - 1;
		if(prio > other.prio)
			return 1;
		return 0;
	}
	
	public int getValue() {
		return value;
	}
	
}
