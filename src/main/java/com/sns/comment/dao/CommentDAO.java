package com.sns.comment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.sns.comment.model.Comment;

@Repository
public interface CommentDAO {
	
	public int insertCommentList(
			@Param("postId") int postId,
			@Param("userId") int userId, 
			@Param("content") String content);
	
	public List<Comment> selectCommentListByPostId(int postId);
	
	public void deleteCommentsByPostId(int postId); 
	
	public void deleteCommentByCommentIdAndUserId(
			@Param("commentId") int commentId, 
			@Param("userId") int userId);
	
}
