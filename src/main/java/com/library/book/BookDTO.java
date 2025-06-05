package com.library.book;

public class BookDTO {
	private Long seqNo;
	private String title;
	private String author;
	private String publisher;
	private String introduction;
	private String publicationDate;
	private String portalExists;
	private Long reviewCount;
	
    public BookDTO() {}

    public BookDTO(Long seqNo, String title, String author, String publisher, String introduction,
                   String publicationDate, String portalExists) {
        this.seqNo = seqNo;
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.introduction = introduction;
        this.publicationDate = publicationDate;
        this.portalExists = portalExists;
        this.reviewCount = 0L;
    }
    
	public Long getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(Long reviewCount) {
		this.reviewCount = reviewCount;
	}

	public Long getSeqNo() {
		return seqNo;
	}

	public void setSeqNo(Long seqNo) {
		this.seqNo = seqNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getPublicationDate() {
		return publicationDate;
	}

	public void setPublicationDate(String publicationDate) {
		this.publicationDate = publicationDate;
	}

	public String getPortalExists() {
		return portalExists;
	}

	public void setPortalExists(String portalExists) {
		this.portalExists = portalExists;
	}
}
