package com.sns.like.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.like.dao.LikeDAO;

@Service
public class LikeBO {

	@Autowired
	private LikeDAO likeDAO;
	
	public void addLike (int postId , int userId){
		boolean exsistLike = exsistLike(postId, userId);
		if(exsistLike) {
			likeDAO.deleteLikeByPostIdUserId(postId, userId);		
		}else {
			likeDAO.insertLike(postId, userId);		
			
		}	
	}
	public boolean exsistLike(int postId, Integer userId) {
		if(userId == null) {
			return false;
		}
		int count = likeDAO.selectExsistLikePostIdUserId(postId, userId);
		return count > 0? true : false;
	}
	public int countLikeByPostId(int postId) {
		return likeDAO.selectExsistLikePostIdUserId(postId, null);
	}
	
	public void deleteLikeByPostIdUserId(int postId, int userId) {
		likeDAO.deleteLikeByPostIdUserId(postId, userId);
	}
	public void deleteLikeByPostId(int postId) {
		likeDAO.deleteLikeByPostId(postId);
	}

	
}
