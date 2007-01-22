#!/usr/bin/env gosh
;; -*- coding: euc-jp -*-

(use text.html-lite)
(use text.tree)

(define *version* "0.1.1")
(define *last-update* "Mon Jan 22 2007")

(define-syntax def
  (syntax-rules (en ja procedure method)
	((_ lang)
	 '())
	((_ en ((type name ...) (p ...) (q ...)) rest ...)
	 (def en ((type name ...) (p ...)) rest ...))
	((_ ja ((type name ...) (p ...) (q ...)) rest ...)
	 (def ja ((type name ...) (q ...)) rest ...))
	((_ lang ((procedure (name arg ...) ...) (p ...)) rest ...)
	 (list*
	  (html:h3 (html:span :class "type" "procedure") ": "
			   (html:span :class "procedure" (html-escape-string (symbol->string 'name))) " "
			   (cons (html:span :class "argument" 'arg) " ") ...)
	  ...
	  (html:p (html-escape-string p))
	  ...
	  (html:hr)
	  (def lang rest ...)))
	((_ lang ((method (name arg ...) ...) (p ...)) rest ...)
	 (list*
	  (html:h3 (html:span :class "type" "method") ": "
			   (html:span :class "method" (html-escape-string (symbol->string 'name))) " "
			   (cons (html:span :class "argument" (html-escape-string (x->string 'arg))) " ") ...)
	  ...
	  (html:p (html-escape-string p))
	  ...
	  (html:hr)
	  (def lang rest ...)))
	((_ lang ((type name ...) (p ...)) rest ...)
	 (list*
	  (html:h3 (html:span :class "type" 'type) ": "
			   (html:span :class 'type (html-escape-string (symbol->string 'name))))
	  ...
	  (html:p (html-escape-string p))
	  ...
	  (html:hr)
	  (def lang rest ...)))))

(define-macro (api-libavcodec lang)
  `(def ,lang

	   ((class <avcodec-context>)
		("Each instance of the class has a pointer to its own AVCodecContext.")
		("�ƥ��󥹥��󥹤� AVCodecContext �ؤΥݥ��󥿤�����ޤ���"))

	   ((method (close-input-avcodec (c <avcodec-context>)))
		("Close the <avcodec-context> `c'. GC will do that finally even if you leave it open.")
		("<avcodec-context> `c' ���Ĥ��ޤ������Τޤޤˤ��Ƥ����� gc ���ǽ�Ū���Ĥ��ޤ���"))

	   ((procedure (avcodec-version))
		("Return the libavcodec's version, e.g. \"51.27.0\".")
		("libavcodec �ΥС������(��: \"51.27.0\")��ʸ����Ȥ����֤��ޤ���"))

	   ((method (get-bit-rate (c <avcodec-context>)))
		("(For audio only) Return the bit rate of `c'.")
		("(�����ǥ����Τ�) `c' �Υӥåȥ졼�Ȥ��֤��ޤ���"))

	   ((method (get-sample-rate (c <avcodec-context>)))
		("(For audio only) Return the sample rate of `c'.")
		("(�����ǥ����Τ�) `c' �Υ���ץ�졼�Ȥ��֤��ޤ���"))

	   ((method (get-width (c <avcodec-context>)))
		("(For video only) Return the width of `c'.")
		("(�ӥǥ��Τ�) `c' �β������֤��ޤ���"))

	   ((method (get-height (c <avcodec-context>)))
		("(For video only) Return the height of `c'.")
		("(�ӥǥ��Τ�) `c' �ν������֤��ޤ���"))

	   ((method (get-codec-name (c <avcodec-context>)))
		("Return its codec name as a string, or #f if failed.")
		("�����ǥå���̾����ʸ������֤��ޤ���̾���������Ǥ��ʤ����� #f ���֤��ޤ���"))
	   ))

(define-macro (api-libavformat lang)
  `(def ,lang

	   ((class <avformat-context>)
		("Each instance of the class has a pointer to its own AVFormatContext.")
		("�ƥ��󥹥��󥹤� AVFormatContext �ؤΥݥ��󥿤�����ޤ���"))

	   ((procedure (avformat-version))
		("Return the libavformat's version, e.g. \"51.6.0\".")
		("libavformat �ΥС������(��: \"51.6.0\")��ʸ����Ȥ����֤��ޤ���"))

	   ((method (open-input-avformat (path <string>)))
		("Open and return a <avformat-context> of the av file of path `path', or #f if falied.")
		("`path' �ˤ���ե�����򿷤��˳��� <avformat-context> ���֤��ޤ������Ԥ������ˤ� #f ���֤��ޤ���"))

	   ((method (close-input-avformat (c <avformat-context>)))
		("Close a <avformat-context> `c'. GC will do that after all if you do not care.")
		("`c' ���Ĥ��ޤ��������줿 <avformat-context> �򤽤Τޤޤˤ��Ƥ����� GC �ˤ�ä��Ĥ����ޤ���"))

	   ((method (get-duration (c <avformat-context>)))
		("Return the number of seconds in duration of `c'")
		("`c' �κ������֤���ñ�̤��֤��ޤ���"))

	   ((method (get-file-name (c <avformat-context>)))
		("Return the plain name of the media file of `c', or #f if failed.")
		("`c' �Υ�ǥ����ե�����Υե�����̾���֤��ޤ����ե�����̾�������Ǥ��ʤ����� #f ���֤��ޤ���"))

	   ((procedure (call-with-input-avformat path proc))
		("Call `proc' with a <avformat-context>, which newly open the file of path `path', as a single argument, and return the value `proc' does in case of success."
		 "The <avformat-context> will be closed before the procedure returns with an error or without.")
		("`path' �ˤ���ե�����򿷤��˳��������� <avformat-context> ��ͣ��ΰ����Ȥ��� `proc' ��ƤӤޤ��������������ˤ� `proc' ���֤����ͤ��֤��ޤ���"
		 "���μ�³������������ˤ��� <avformat-context> ���Ĥ����ޤ���"))
	   ))

(define-macro (api-ffmpeg lang)
  `(def ,lang
		((method (open-input-acodec (c <avformat-context>))
				 (open-input-vcodec (c <avformat-context>))
				 (open-input-avcodec (c <avformat-context>)))
		 ("The first form opens and returns a audio <avcodec-context> from `c'. The second one does a video <avcodec-context>. And the last simultaneously returns both values i.e. audio and video codec contexts in that order."
		  "Any of them returns #f if failed.")
		 ("�ǽ�Υ᥽�åɤ� `c' ���饪���ǥ����� <avcodec-context> �򳫤����֤��ޤ���2���ܤ�Ʊ���褦�˥ӥǥ��� <avcodec-context> ���֤��ޤ��������ƺǸ��Ʊ���˥����ǥ������ӥǥ�ξ�����ͤ򤳤ν��֤��֤��ޤ���"
		  "���Ԥ������Ϥ������ #f ���֤��ޤ���"))

		((method (get-frame-rate (fc <avformat-context>) (cc <avcodec-context>)))
		 ("Return two numbers: the numerator and denominator of the frame rate of video with `fc' and `cc'."
		  "Given `cc' must be a video context."
		  "Note: the mothod will be not idempotent (currently at least) since it may occur a side effect for `fc'.")
		 ("�ե졼��졼�Ȥ�ʬ�Ҥ�ʬ���2�Ĥο��ͤ��֤��ޤ���"
		  "Ϳ������`cc' �ϥӥǥ��� context �Ǥʤ���Фʤ�ޤ���"
		  "���: ���Υ᥽�åɤ�(���ʤ��Ȥ⸽�����Ǥ�)�����֤��ƤӽФ��Ȱ����Ǥʤ����⤷��ޤ���"))

		((procedure (call-with-input-avcodec fc proc))
		 ("Call `proc' with the following two arguments: an audio <avcodec-context> and video <avcodec-context>, which are newly opened from `fc'."
		  "Return the value `proc' does in case of success. The <avcodec-context>s will be closed before the procedure returns with an error or without.")
		 ("`proc' �򼡤�2�Ĥΰ����ȤȤ�˸ƤӤޤ�: `fc' ���鳫����(1)�����ǥ����� <avcodec-context> ��(2)�ӥǥ��� <avcodec-context>��"
		  "����������礳�μ�³���� `proc' ������ͤ��ᤷ�ޤ��������줿 context �ϼ�³��������������Ĥ����ޤ���"))
		))

(define (document-tree lang)
  (let ((title (if (eq? 'ja lang) "Gauche-ffmpeg ��ե���󥹥ޥ˥奢��" "Gauche-ffmpeg Reference Manual")))
	(html:html
	 (html:head
	  (if (eq? 'ja lang) (html:meta :http-equiv "Content-Type" :content "text/html; charset=EUC-JP") '())
	  (html:title title))
	 (html:body
	  (html:h1 title)
	  (html:style
	   :type "text/css"
	   "<!-- \n"
	   "h2 { background-color:#dddddd; }\n"
	   "address { text-align: right; }\n"
	   ".type { font-size: medium; text-decoration: underline; }\n"
	   ".procedure { font-size: medium; font-weight: normal; }\n"
	   ".method { font-size: medium; font-weight: normal; }\n"
	   ".argument { font-size: small; font-style: oblique; font-weight: normal; }\n"
	   ".constant { font-size: medium; font-weight: normal; }\n"
	   ".variable { font-size: medium; font-weight: normal; }\n"
	   "#last_update { text-align: right; font-size: small; }\n"
	   "#project { text-align: right; }\n"
	   " -->")
	  (html:p "For version " *version*)
	  (html:p :id "last_update" "last update: " *last-update*)
	  (html:p :id "project" (html:a :href "http://www.fixedpoint.jp/gauche-ffmpeg/" "http://www.fixedpoint.jp/gauche-ffmpeg/"))
	  (if (eq? 'en lang)
		  (html:p (html:span :style "color:red;" "Warning:") " still unstable.")
		  (html:p (html:span :style "color:red;" "�ٹ�:") " �����ѹ��β�ǽ��������ޤ���"))
	  (html:h2 "API for libavcodec")
	  (if (eq? 'en lang)
		  (api-libavcodec en)
		  (api-libavcodec ja))
	  (html:h2 "API for libavformat")
	  (if (eq? 'en lang)
		  (api-libavformat en)
		  (api-libavformat ja))
	  (html:h2 "API for ffmpeg")
	  (if (eq? 'en lang)
		  (api-ffmpeg en)
		  (api-ffmpeg ja))
	  (html:address "&copy; 2006,2007 Takeshi Abe")
	  ))))

(define (main args)
  (define (usage)
	(format (current-error-port) "usage: gosh reference.scm (en|ja)\n")
	(exit 1))
  (when (< (length args) 2)
	(usage))
  (write-tree (document-tree (string->symbol (cadr args))))
  0)
