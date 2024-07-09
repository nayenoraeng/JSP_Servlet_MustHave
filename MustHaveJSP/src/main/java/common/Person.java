package common; //기본 패키지 이외의 패키지(규약1번)
/*
	순수하게 데이터 저장 기능만 있는 클래스를 DTO
	혹은 VO 라고 부른다
	자바빈즈 규약에 따라 작성한다.
	
	자바빈즈 규약
	1. 자바
*/

public class Person {
	private String name; //private 멤버 변수 (규약 2번)
	private int age;
	
	public Person() {} //기본 생성자(규약3번)
	public Person(String name, int age)
	{
		super();
		this.name = name;
		this.age = age;
	}
	
	//public 게터/세터 멤버 메서드 (규약 4번,5번)
	public String getName()
	{
		return name;
	}
	
	public void setName(String name)
	{
		this.name = name;
	}
	
	public int getAge()
	{
		return age;
	}
	
	public void setAge(int age)
	{
		this.age = age;
	}
	
	

}
