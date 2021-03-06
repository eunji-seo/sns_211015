package com.sns.post.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.sns.post.model.Post;
import com.sns.timeline.model.ContentView;

@Repository
public interface PostDAO {

	public List<Post> selectPostList();
	
	public Post selectPostByPostIdAndUserId(
			@Param("postId") int postId, 
			@Param("userId") int userId);
	
	public void insertPost(
			@Param("userId") int userId, 
			@Param("content") String content, 
			@Param("imagePath") String imagePath);
	
	public List<ContentView> selectCommentList(Integer userId);
	
	public void deletePost(
			@Param("postId") int postId, 
			@Param("userId") int userId);
}
