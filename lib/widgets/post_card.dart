import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/services/firestore_methodes.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isLikeAnimaton = false;
  @override
  Widget build(BuildContext context) {
    //user
    final User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    widget.snap["profilePic"],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap["userName"],
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Text(
                          "user.bio",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: webBackgroundColor,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              onTap: () async {
                                await FirestoreMethodes()
                                    .deletePost(postId: widget.snap['postId']);
                                Navigator.pop(context);
                              },
                              leading: const Icon(Icons.delete),
                              title: const Text("Delete"),
                            ),
                            ListTile(
                              onTap: () {
                                //:TODO delete the post
                              },
                              leading: const Icon(Icons.edit),
                              title: const Text("Edit"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),

          //? post Image

          GestureDetector(
            onDoubleTap: () async {
              await FirestoreMethodes().likePosts(
                likes: widget.snap['likes'],
                postID: widget.snap['postId'],
                uid: user.uid,
              );
              setState(() {
                _isLikeAnimaton = true;
              });
            },
            child: Stack(alignment: Alignment.center, children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                child: Image.network(
                  widget.snap["postURL"],
                  fit: BoxFit.cover,
                ),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: _isLikeAnimaton ? 1 : 0,
                child: LikeAnimation(
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 120,
                  ),
                  isAnimating: _isLikeAnimaton,
                  duration: Duration(milliseconds: 400),
                  onEnd: () {
                    setState(() {
                      _isLikeAnimaton = false;
                    });
                  },
                ),
              )
            ]),
          ),

          //reactions
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                    onPressed: () async {
                      await FirestoreMethodes().likePosts(
                        likes: widget.snap['likes'],
                        postID: widget.snap['postId'],
                        uid: user.uid,
                      );
                    },
                    icon: widget.snap['likes'].contains(user.uid)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.red,
                          )),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.comment_bank_outlined,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.bookmark_border_outlined,
                    ),
                  ),
                ),
              ),
            ],
          ),

          //?description and ccomments

          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.snap['likes'].length} likes",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white60,
                      ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),

                  //rich text will allow to use many texts
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.snap['userName'],
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        TextSpan(
                          text: "  ${widget.snap['description']}",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white60,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),

                //comments
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      "view all commentts",
                      style: TextStyle(fontSize: 15, color: secondaryColor),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    DateFormat.yMMMd()
                        .format(widget.snap['datePosted'].toDate()),
                    style: TextStyle(fontSize: 12, color: secondaryColor),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
