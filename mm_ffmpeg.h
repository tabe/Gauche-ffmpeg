/*
 *  mm_ffmpeg.h
 *
 *   Copyright (C) 2006,2007 Takeshi Abe. All rights reserved.
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

#ifndef GAUCHE_MM_FFMPEG_H
#define GAUCHE_MM_FFMPEG_H

#include <gauche.h>
#include <gauche/extend.h>

#include <assert.h>

#include "mm_avcodec.h"
#include "mm_avformat.h"

SCM_DECL_BEGIN

AVCodecContext *ffmpegOpenVideoCodecContext(AVFormatContext *pFormatCtx);
AVCodecContext *ffmpegOpenAudioCodecContext(AVFormatContext *pFormatCtx);
int ffmpegOpenCodecContext(AVFormatContext *pFormatCtx, AVCodecContext **a, AVCodecContext **v);
int ffmpegGetFrameRate(AVFormatContext *pFormatCtx, AVCodecContext *pCodecCtx, int *pNum, int *pDen);

SCM_DECL_END

#endif  /* GAUCHE_MM_FFMPEG_H */
