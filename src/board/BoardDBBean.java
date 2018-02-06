package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

//db에 넣어주기만 하는 프로그램. 모든 유저가 글쓰기시 새로 인스턴스를 생성할 필요가 없음. 
//싱글턴방식

public class BoardDBBean {
	private static BoardDBBean instance=new BoardDBBean();
	private BoardDBBean() {
		//외부에서 생성할 수 없도록 생성자 private로 막아놓음
	}
	public static BoardDBBean getInstance() {
		//instance객체의 주소 반환
		return instance;
	}
	
	//getConnection메서드 > connection객체를 이 객체에서 만든 다는 것
	//preparedStatement 와 결과만 구현하면 됨
	public static Connection getConnection(){
		Connection con=null;
		try {
			String jdbcUrl="jdbc:oracle:thin:@localhost:1521:orcl";
			String dbID="scott";
			String dbPass="tiger";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con=DriverManager.getConnection(jdbcUrl, dbID, dbPass);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return con;
	}
	public void insertArticle(BoardDataBean article) {
		//db 데이터 삽입 메서드
		String sql="";
		Connection con=getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int number=0;
		try {//serial number 진행시키기 위한 sql문 <-num컬럼 
			pstmt=con.prepareStatement("select boardser.nextval from dual");
			rs=pstmt.executeQuery();
			if(rs.next())
				number=rs.getInt(1)+1;
			else
				number=1;
			
			sql="insert into board(num,writer,email,subject,passwd,reg_date,"
					+ "ref,re_step,re_level,content,ip,boardid)"
					+ "values(?,?,?,?,?,sysdate,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, number);
			pstmt.setString(2, article.getWriter());
			pstmt.setString(3, article.getEmail());
			pstmt.setString(4, article.getSubject());
			pstmt.setString(5, article.getPasswd());
			pstmt.setInt(6, number);
			pstmt.setInt(7, 0);
			pstmt.setInt(8, 0);
			pstmt.setString(9, article.getContent());
			pstmt.setString(10, article.getIp());
			pstmt.setString(11, article.getBoardid());
			pstmt.executeUpdate();
			
		}catch(SQLException e1) {
			e1.printStackTrace();
			
		}finally {
			close(con,rs,pstmt);	
			//닫는 메서드
			//매개변수가 있어야함. 열어놓은 것들 달고 들어가야함
		}
	}
	
	public int getArticleCount(String boardid) {
		//총 글의 개수 count해줌
		int x=0;
		String sql="select nvl(count(*),0) "
				+ "from board where boardid=?";
		//* 안들어감. 값이 없을때를 위해 nvl()입력. (null일 때 0)
		Connection con=getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int number=0;
		
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, boardid);
			//?에 parameter boardid 넣어줌
			rs=pstmt.executeQuery();
			//쿼리실행 후 결과 값 resultSet에 담기
			if(rs.next()) {
				x=rs.getInt(1);
				//rs에 담긴 총 게시판 글 수를 x에 넣어줌
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(con,rs,pstmt);
		}
		return x;
	}
	public List getArticles(int startRow,int endRow,String boardid) {
		//게시판 글을 startRow부터  endRow까지 list에 담아 리턴
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List articleList=null;
		String sql="";
		try {
			conn=getConnection();
			sql="select*from"
					+ "(select rownum rnum,a.* from"
					+ "(select num,writer,email,subject,passwd,"
					+ "reg_date,readcount,ref,re_step,re_level,content,"
					+ "ip from board where boardid=? order by ref desc,re_step)"
					+ "a) where rnum between ? and ?";
				//ref 내림차순 기준(최신 글부터)으로 정렬. 
				//rownum 값이 작을 수록 최신글. startRow <- 불러오는 영역중 가장 최신 글
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, boardid);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				articleList=new ArrayList();
				//BoardDataBean article=new BoardDataBean();
				//BoardDataBean do-while밖에다가 쓰면 안됨. 가장 마지막으로 불러온 데이터값으로 덮어 씌워짐.
				//모든 articleList 안의 객체들이 하나의 인스턴스를 가리키게됨.
				do {
					BoardDataBean article=new BoardDataBean();
					//while문 반복 될 때마다 객체 생성
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getShort("re_level"));
					article.setContent(rs.getString("content"));
					article.setIp(rs.getString("ip"));
					//생성한 article 객체에다가 값을 세팅해줌
					articleList.add(article);
					//articleList에 생성한 article객체를 저장
				}while(rs.next());
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			close(conn,rs,pstmt);
		}
		return articleList;	
	}

	
	public void close(Connection con,ResultSet rs,PreparedStatement pstmt) {
		//커넥션 닫는 메서드
		if(rs!=null)
			try {
				rs.close();
			}catch(SQLException ex) {}
		if(pstmt!=null)
			try {
				pstmt.close();
			}catch(SQLException ex) {}
		if(con!=null)
			try {
				con.close();
			}catch(SQLException ex) {}
	}
	

}
