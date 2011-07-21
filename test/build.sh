LINK="../lib/libffmpeg_fas.so -lm -lz "
gcc ./dump_frames/dump_frames.c -I.. $LINK -o dump_frames
gcc ./dump_keyframes/dump_keyframes.c -I.. $LINK -o dump_keyframes
gcc ./movie_info/movie_info.c -I.. $LINK -o movie_info
gcc ./show_seek_table/show_seek_table.c -I.. $LINK -o show_seek_table
gcc ./seek_test/seek_test.c -I.. $LINK -o seek_test
gcc external_seek_test.c -I.. $LINK -o external_seek_test
gcc generate_seek_table.c -I.. -I../ffmpeg/ ../ffmpeg/libavformat/libavformat.a ../ffmpeg/libavutil/libavutil.a ../ffmpeg/libavcodec/libavcodec.a -lm -lz ../lib/libffmpeg_fas.so -o generate_seek_table