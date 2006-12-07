/*
 *  mm_ffmpeg.c
 *
 *   Copyright (C) 2006 Takeshi Abe. All rights reserved.
 *
 *   This library is free software; you can redistribute it and/or
 *   modify it under the terms of the GNU Lesser General Public
 *   License as published by the Free Software Foundation; either
 *   version 2.1 of the License, or (at your option) any later version.
 *
 *   This library is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *   Lesser General Public License for more details.
 *
 *   You should have received a copy of the GNU Lesser General Public
 *   License along with this library; if not, write to the Free Software
 *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 *
 *  $Id$
 */

#include "mm_ffmpeg.h"

#define DEFINE_OPEN_CODEC_CONTEXT(name, type) AVCodecContext *			\
  name(AVFormatContext *pFormatCtx) {									\
	int i;																\
	for (i = 0; i < pFormatCtx->nb_streams; i++) {						\
	  AVCodecContext *pCodecCtx = pFormatCtx->streams[i]->codec;		\
	  if (pCodecCtx->codec_type == (type)) {							\
		AVCodec *pCodec;												\
		if ( (pCodec = avcodec_find_decoder(pCodecCtx->codec_id)) == NULL) { \
		  continue;														\
		} else if (avcodec_open(pCodecCtx, pCodec) < 0) {				\
		  continue;														\
		} else {														\
		  return pCodecCtx;												\
		}																\
	  }																	\
	}																	\
	return NULL;														\
  }

DEFINE_OPEN_CODEC_CONTEXT(ffmpegOpenVideoCodecContext, CODEC_TYPE_VIDEO)
DEFINE_OPEN_CODEC_CONTEXT(ffmpegOpenAudioCodecContext, CODEC_TYPE_AUDIO)
#undef DEFINE_OPEN_CODEC_CONTEXT

int
ffmpegOpenCodecContext(AVFormatContext *pFormatCtx, AVCodecContext **a, AVCodecContext **v)
{
  int i;
  AVCodec *pCodec;
  *a = *v = NULL;
  for (i = 0; i < pFormatCtx->nb_streams; i++) {
	AVCodecContext *pCodecCtx = pFormatCtx->streams[i]->codec;
	switch (pCodecCtx->codec_type) {

#define FIND_DECODER_AND_OPEN_CODEC_CONTEXT(target, co_target)			\
	  if ( (pCodec = avcodec_find_decoder(pCodecCtx->codec_id)) == NULL) { \
		continue;														\
	  }	else if (avcodec_open(pCodecCtx, pCodec) < 0) {					\
		continue;														\
	  } else {															\
		target = pCodecCtx;												\
		if (co_target) return i;										\
	  }																	\
	  break

	case CODEC_TYPE_AUDIO: FIND_DECODER_AND_OPEN_CODEC_CONTEXT(*a, *v);
	case CODEC_TYPE_VIDEO: FIND_DECODER_AND_OPEN_CODEC_CONTEXT(*v, *a);

#undef FIND_DECODER_AND_OPEN_CODEC_CONTEXT
	}
  }
  return i;
}

#define FIND_STREAM_INDEX(pFromatCtx, pCodecCtx, v) do {	\
	int i;													\
	for (i = 0; i < pFormatCtx->nb_streams; i++) {			\
	  if (pCodecCtx == pFormatCtx->streams[i]->codec) {		\
		v = i;												\
		break;												\
	  }														\
	}														\
  } while (0)

#define GET_FRAME_RATE(pStream, n, d) do {							\
	assert(pStream->codec->codec_type == CODEC_TYPE_VIDEO);			\
	if (pStream->r_frame_rate.den && pStream->r_frame_rate.num) {	\
	  /* r = av_q2d(pStream->r_frame_rate); */						\
	  (n) = pStream->r_frame_rate.num;								\
	  (d) = pStream->r_frame_rate.den;								\
	} else {														\
	  /* r = 1 / (av_q2d(pCodecCtx->time_base)); */					\
	  (n) = pStream->time_base.den;									\
	  (d) = pStream->time_base.num;									\
	}																\
  } while (0)

#define GET_TIME_BASE(pStream, n, d) do {							\
	assert(pStream->codec->codec_type == CODEC_TYPE_VIDEO);			\
	if (pStream->r_frame_rate.den && pStream->r_frame_rate.num) {	\
	  (n) = pStream->time_base.num;									\
	  (d) = pStream->time_base.den;									\
	} else {														\
	  (n) = pStream->r_frame_rate.den;								\
	  (d) = pStream->r_frame_rate.num;								\
	}																\
  } while (0)

int
ffmpegGetFrameRate(AVFormatContext *pFormatCtx, AVCodecContext *pCodecCtx, int *pNum, int *pDen)
{
  AVStream *pStream;
  int v;
  *pNum = 0;
  *pDen = 1;
  v = -1;
  FIND_STREAM_INDEX(pFormatCtx, pCodecCtx, v);
  if (v == -1) return -1;
  pStream = pFormatCtx->streams[v];
  GET_FRAME_RATE(pStream, *pNum, *pDen);
  return 0;
}

#undef GET_TIME_BASE
#undef GET_FRAME_RATE
#undef FIND_STREAM_INDEX

ScmObj
Scm_Init_mm_ffmpeg(void)
{
  ScmModule *mod;

  SCM_INIT_EXTENSION(mm_ffmpeg);

  mod = SCM_MODULE(SCM_FIND_MODULE("multimedia.ffmpeg", TRUE));

  Scm_Init_mm_ffmpeglib(mod);
}
