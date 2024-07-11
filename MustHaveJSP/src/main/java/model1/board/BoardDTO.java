package model1.board;

public class BoardDTO {
	private String num;
	private String title;
	private String content;
	private String id;
	private java.sql.Date postdate;
	private String visitcount;	
	private String name;
	
	/*
		member 테이블과 join을 통해 회원 이름을 출력해야 할 때르 ㄹ위해
		멤버변수를 추가한다. DTO는 필요한 경우 다른 테이블의 컬럼을
		멤버 변수로 추가할 수 있다.
	*/
	public String getNum()
	{
		return num;
	}
	public void setNum(String num)
	{
		this.num = num;
	}
	public String getTitle()
	{
		return title;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}
	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}
	public String getId()
	{
		return id;
	}
	public void setId(String id)
	{
		this.id = id;
	}
	public java.sql.Date getPostdate()
	{
		return postdate;
	}
	public void setPostdate(java.sql.Date postdate)
	{
		this.postdate = postdate;
	}
	public String getVisitcount()
	{
		return visitcount;
	}
	public void setVisitcount(String visitcount)
	{
		this.visitcount = visitcount;
	}
	public String getName()
	{
		return name;
	}
	public void setName(String name)
	{
		this.name = name;
	}	
}
