package test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import test.db.DBUtil;
import test.vo.CommentsVo;

public class CommentsDao {
	private static CommentsDao instance=new CommentsDao();
	private CommentsDao() {}
	public static CommentsDao getInstance() {
		return instance;
	}
	
	public int delete(int num) {
		int n=-1;
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="delete from comments where num=?";
		try {
			con=DBUtil.getCon();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			n=pstmt.executeUpdate();
		} catch (SQLException e) {
			 e.printStackTrace();
		}finally {
			DBUtil.close(con, pstmt);
		}
		return n;
	}
	
	public int insert(CommentsVo vo) {
		int n=-1;
		Connection con= null;
		PreparedStatement pstmt=null;
		String sql="insert into comments values(comments_seq.nextval,?,?,?)";
		try {
			con=DBUtil.getCon();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, vo.getMnum());
			pstmt.setString(2, vo.getId());
			pstmt.setString(3, vo.getComments());
			n=pstmt.executeUpdate();
		} catch (SQLException e) {
			 e.printStackTrace();
		}finally {
			DBUtil.close(con, pstmt);
		}
		return n;
	}
	
	public ArrayList<CommentsVo> cList(int mnum, int startRow,int endRow){
		ArrayList<CommentsVo> list=new ArrayList<CommentsVo>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from "
				+ "( "
				+ "		select com.*, rownum rnum from"
				+ "		( "
				+ "			select * from comments "
				+ "			where mnum=? "
				+ "			order by num desc "
				+ "		) com "
				+ ") where rnum>=? and rnum<=?";
		try {
			con=DBUtil.getCon();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				int num=rs.getInt("num");
				String id=rs.getString("id");
				String comments=rs.getString("comments");
				CommentsVo vo=new CommentsVo(num, mnum, id, comments);
				list.add(vo);
			}
		} catch (SQLException e) {
			 e.printStackTrace();
		}finally {
			DBUtil.close(con, pstmt, rs);
		}
		return list;
	}
	
	public int getCount(int mnum) {
		int cnt=-1;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select NVL(count(*),0) as cnt from comments where mnum=?";
		try {
			con=DBUtil.getCon();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			rs=pstmt.executeQuery();
			rs.next();
			cnt=rs.getInt(1);
		}catch (SQLException e) {
			 e.printStackTrace();
		}finally {
			DBUtil.close(con, pstmt, rs);
		}
		return cnt;
	}
}
