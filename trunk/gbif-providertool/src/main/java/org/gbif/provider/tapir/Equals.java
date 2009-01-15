package org.gbif.provider.tapir;

public class Equals extends ComparisonBinaryOperator {

	public Equals() {
		log.debug("Creating " + this.getClass().getSimpleName());
	}
	
	@Override
	protected String getOperatorSymbol() {
		return "=";
	}
}
