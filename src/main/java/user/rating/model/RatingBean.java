package user.rating.model;

public class RatingBean {

	private int reviewnum;
	private String reviewtype;
	private String ratingtype;
	private int starranking;
	private String regid;
	private String regdate;
	private String modid;
	private String moddate;

	private int svgStar; // 평균값 낼때 사용할 컬럼.

	public RatingBean() {
	}

	public int getReviewnum() {
		return reviewnum;
	}

	public void setReviewnum(int reviewnum) {
		this.reviewnum = reviewnum;
	}

	public String getReviewtype() {
		return reviewtype;
	}

	public void setReviewtype(String reviewtype) {
		this.reviewtype = reviewtype;
	}

	public String getRatingtype() {
		return ratingtype;
	}

	public void setRatingtype(String ratingtype) {
		this.ratingtype = ratingtype;
	}

	public int getStarranking() {
		return starranking;
	}

	public void setStarranking(int starranking) {
		this.starranking = starranking;
	}

	public String getRegid() {
		return regid;
	}

	public void setRegid(String regid) {
		this.regid = regid;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getModid() {
		return modid;
	}

	public void setModid(String modid) {
		this.modid = modid;
	}

	public String getModdate() {
		return moddate;
	}

	public void setModdate(String moddate) {
		this.moddate = moddate;
	}

	public int getSvgStar() {
		return svgStar;
	}

	public void setSvgStar(int svgStar) {
		this.svgStar = svgStar;
	}

	@Override
	public String toString() {
		return "RatingBean [reviewnum=" + reviewnum + ", reviewtype=" + reviewtype + ", ratingtype=" + ratingtype
				+ ", starranking=" + starranking + ", regid=" + regid + ", regdate=" + regdate + ", modid=" + modid
				+ ", moddate=" + moddate + ", svgStar=" + svgStar + "]";
	}

}
