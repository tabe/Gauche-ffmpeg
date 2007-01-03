/*
 *  mm_avformat.c
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

#include "mm_avformat.h"

ScmClass *AVFormatContextClass;

static void
avformatContextCleanUp(ScmObj obj)
{
  if (!avformatContextClosedP(obj)) {
	AVFormatContext *p = AVFORMAT_CONTEXT_UNBOX(obj);
	AVFORMAT_CONTEXT_CLEAN_UP(p);
  }
}

static ScmObj sym_closed;

int
avformatContextClosedP(ScmObj obj)
{
  SCM_ASSERT(SCM_FOREIGN_POINTER_P(obj));
  return !SCM_FALSEP(Scm_ForeignPointerAttrGet(SCM_FOREIGN_POINTER(obj),
											   sym_closed, SCM_FALSE));
}

void
avformatContextMarkClosed(ScmObj obj)
{
  SCM_ASSERT(SCM_FOREIGN_POINTER_P(obj));
  Scm_ForeignPointerAttrSet(SCM_FOREIGN_POINTER(obj),
							sym_closed, SCM_TRUE);
}

AVFormatContext *
avformatOpenInputContext(const char *path)
{
  AVFormatContext *ctx;
  if ( av_open_input_file(&ctx, path, NULL, 0, NULL) != 0) {
	return NULL;
  } else if (av_find_stream_info(ctx) < 0) {
	av_close_input_file(ctx);
	return NULL;
  } else {
	return ctx;
  }
}

double
avformatContextGetDuration(AVFormatContext *ctx)
{
  int64_t duration = ctx->duration;
  return (duration == AV_NOPTS_VALUE) ? -1 : (duration / AV_TIME_BASE);
}

ScmObj
Scm_Init_mm_avformat(void)
{
  ScmModule *mod;

  SCM_INIT_EXTENSION(mm_avformat);

  mod = SCM_MODULE(SCM_FIND_MODULE("multimedia.avformat", TRUE));

  AVFormatContextClass =
	Scm_MakeForeignPointerClass(mod, "<avformat-context>",
								NULL, avformatContextCleanUp, SCM_FOREIGN_POINTER_KEEP_IDENTITY|SCM_FOREIGN_POINTER_MAP_NULL);

  sym_closed = SCM_INTERN("closed?");

  av_register_all(); // defined in allformats.c

  Scm_Init_mm_avformatlib(mod);
}
