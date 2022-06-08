package test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import test.db.DBUtil;
import test.vo.MovieVo;

public class MovieDao {
	private static MovieDao instance=new MovieDao();
	private MovieDao() {}
	public static MovieDao getInstance() {
		return instance;
	}
	
	public MovieVo getInfo(int mnum) {
		MovieVo vo=null;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from movie where mnum=?";
		try {
			con=DBUtil.getCon();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				String title=rs.getString("title");
				String content=rs.getString("content");
				String director=rs.getString("director");
				vo=new MovieVo(mnum, title, content, director);
			}
		} catch (SQLException e) {
			 e.printStackTrace();
		}finally {
			DBUtil.close(con, pstmt, rs);
		}	
		return vo;
	}
	
	public ArrayList<MovieVo> getList() {
		ArrayList<MovieVo> list=new ArrayList<MovieVo>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from movie";
		try {
			con=DBUtil.getCon();
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				int mnum=rs.getInt("mnum");
				String title=rs.getString("title");
				String content=rs.getString("content");
				String director=rs.getString("director");
				MovieVo vo=new MovieVo(mnum, title, content, director);
				list.add(vo);
			}
		}catch (SQLException e) {
			 e.printStackTrace();
		}finally {
			DBUtil.close(con, pstmt, rs);
		}
		return list;	
				
	}
}
