package admin.community.model;

public class CommunityRatingBean {

	private String ratingtype;
	private String reviewtype;
	private int good;
	private int jjem;
	private int starsum;
	private int staravg;

	public CommunityRatingBean() {
	}

	public String getRatingtype() {
		return ratingtype;
	}

	public void setRatingtype(String ratingtype) {
		this.ratingtype = ratingtype;
	}

	public String getReviewtype() {
		return reviewtype;
	}

	public void setReviewtype(String reviewtype) {
		this.reviewtype = reviewtype;
	}

	public int getGood() {
		return good;
	}

	public void setGood(int good) {
		this.good = good;
	}

	public int getJjem() {
		return jjem;
	}

	public void setJjem(int jjem) {
		this.jjem = jjem;
	}

	public int getStarsum() {
		return starsum;
	}

	public void setStarsum(int starsum) {
		this.starsum = starsum;
	}

	public int getStaravg() {
		return staravg;
	}

	public void setStaravg(int staravg) {
		this.staravg = staravg;
	}

}
