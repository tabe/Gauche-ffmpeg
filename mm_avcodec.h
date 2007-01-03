/*
 *  mm_avcodec.h
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

#ifndef GAUCHE_MM_AVCODEC_H
#define GAUCHE_MM_AVCODEC_H

#include <ffmpeg/avcodec.h>

#include <gauche.h>
#include <gauche/extend.h>

SCM_DECL_BEGIN

extern ScmClass *AVCodecContextClass;
#define AVCODEC_CONTEXT_P(obj)     SCM_XTYPEP(obj, AVCodecContextClass)
#define AVCODEC_CONTEXT_UNBOX(obj) SCM_FOREIGN_POINTER_REF(AVCodecContext *, obj)
#define AVCODEC_CONTEXT_BOX(ctx)   Scm_MakeForeignPointer(AVCodecContextClass, ctx)

#define AVCODEC_CONTEXT_CLEAN_UP(ctx) do { \
	if (ctx->codec) avcodec_close(ctx);	   \
  } while (0)

int  avcodecContextClosedP(ScmObj obj);
void avcodecContextMarkClosed(ScmObj obj);

const char *avcodecContextGetCodecName(AVCodecContext *pCtx);

SCM_DECL_END

#endif  /* GAUCHE_MM_AVCODEC_H */
