package com.sns.like.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface LikeDAO {
	
	public int selectExsistLikePostIdUserId(
			@Param("postId") int postId, 
			@Param("userId") Integer userId);

	public void insertLike (
			@Param("postId") int postId , 
			@Param("userId") int userId);
	
	public void deleteLikeByPostIdUserId(
			@Param("commentId") int commentId , 
			@Param("userId") int userId);
	
	public void deleteLikeByPostId(int postId);
}
