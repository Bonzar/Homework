use vk;

ALTER table profiles
	add constraint profiles_user_id_fk
		foreign key (user_id) references users(id)
			on delete cascade,
	add constraint profiles_photo_user_id_fk
		foreign key (photo_id) references media(id)
			on delete set NULL;

ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
      ON DELETE SET NULL;
      
SELECT * from communities c ;

UPDATE posts set community_id = FLOOR(1 + RAND() * 20);

describe media

SELECT * from media_types mt;

SELECT * FROM profiles p ;

SELECT * FROM users u;


alter table media
	add constraint media_media_type_id_fk
		foreign key (media_type_id) REFERENCES media_types(id);
	
alter table users
	add constraint users_status_id_fk
		foreign key (status_id) references user_statuses(id)
			on delete set NULL;
	
alter table communities_users 
	add constraint communities_users_community_id_fk
		foreign key (community_id) references communities(id),
	add constraint communities_users_user_id_fk
		foreign key (user_id) references users(id);
	
alter table friendship
	add constraint friendship_user_id_fk
		foreign key (user_id) references users(id),
	add constraint friendship_friend_id_fk
		foreign key (friend_id) references users(id),
	add constraint friendship_status_id_fk
		foreign key (status_id) references friendship_statuses(id);

alter table messages 
	add constraint massages_from_user_id_fk
		foreign key (from_user_id) references users(id),
	add constraint masseges_to_user_id_fk
		foreign key (to_user_id) references users(id),
	add constraint masseges_media_id_fk
		foreign key (media_id) references media(id)
			on delete set NULL;

alter table posts
	add constraint posts_user_id_fk
		foreign key (user_id) references users(id),
	add constraint posts_community_id_fk
		foreign key (community_id) references communities(id),
	add constraint posts_media_id_fk
		foreign key (media_id) references media(id)
			on delete set NULL;

alter table likes
	add constraint likes_user_id_fk
		foreign key (user_id) references users(id),
	add constraint likes_target_type_id
		foreign key (target_type_id) references target_types(id);



