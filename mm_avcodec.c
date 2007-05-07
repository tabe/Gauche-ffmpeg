/*
 *  mm_avcodec.c
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

#include "mm_avcodec.h"

/* ScmClass *AVCodecClass; */
ScmClass *AVCodecContextClass;

static void
avcodecContextCleanUp(ScmObj obj)
{
  if (!avcodecContextClosedP(obj)) {
	AVCodecContext *p = AVCODEC_CONTEXT_UNBOX(obj);
	AVCODEC_CONTEXT_CLEAN_UP(p);
  }
}

static ScmObj sym_closed;

int
avcodecContextClosedP(ScmObj obj)
{
  SCM_ASSERT(SCM_FOREIGN_POINTER_P(obj));
  return !SCM_FALSEP(Scm_ForeignPointerAttrGet(SCM_FOREIGN_POINTER(obj),
											   sym_closed, SCM_FALSE));
}

void
avcodecContextMarkClosed(ScmObj obj)
{
  SCM_ASSERT(SCM_FOREIGN_POINTER_P(obj));
  Scm_ForeignPointerAttrSet(SCM_FOREIGN_POINTER(obj),
							sym_closed, SCM_TRUE);
}

static ScmInternalMutex mm_avcodec_context_mutex;

int
mm_avcodec_open(AVCodecContext *pCtx, AVCodec *pCodec)
{
  int r;
  (void)SCM_INTERNAL_MUTEX_LOCK(mm_avcodec_context_mutex);
  r = avcodec_open(pCtx, pCodec);
  (void)SCM_INTERNAL_MUTEX_UNLOCK(mm_avcodec_context_mutex);
  return r;
}

int
mm_avcodec_close(AVCodecContext *pCtx)
{
  int r;
  (void)SCM_INTERNAL_MUTEX_LOCK(mm_avcodec_context_mutex);
  r = avcodec_close(pCtx);
  (void)SCM_INTERNAL_MUTEX_UNLOCK(mm_avcodec_context_mutex);
  return r;
}

const char *
avcodecContextGetCodecName(AVCodecContext *pCtx)
{
  AVCodec *pCodec = avcodec_find_decoder(pCtx->codec_id);
  if (pCodec) return pCodec->name;
  return (const char *)NULL;
}

ScmObj
Scm_Init_mm_avcodec(void)
{
  ScmModule *mod;

  (void)SCM_INTERNAL_MUTEX_INIT(mm_avcodec_context_mutex);
  SCM_INIT_EXTENSION(mm_avcodec);

  mod = SCM_MODULE(SCM_FIND_MODULE("multimedia.avcodec", TRUE));

  AVCodecContextClass =
	Scm_MakeForeignPointerClass(mod, "<avcodec-context>",
								NULL, avcodecContextCleanUp, SCM_FOREIGN_POINTER_KEEP_IDENTITY|SCM_FOREIGN_POINTER_MAP_NULL);

  sym_closed = SCM_INTERN("closed?");

  avcodec_init();         // defined in utils.c
  avcodec_register_all(); // defined in allcodecs.c

  Scm_Init_mm_avcodeclib(mod);
}
