#!/usr/bin/env gosh
;; -*- coding: euc-jp -*-

(use text.html-lite)
(use text.tree)

(define *version* "0.1.1")
(define *last-update* "Tue Jan 22 2008")

(define-syntax def
  (syntax-rules (en ja procedure method)
	((_ en)
     '())
    ((_ ja)
	 '())
	((_ en (synopsis x y z ...) rest ...)
     (cons
      (def (synopsis x z ...))
      (def en rest ...)))
	((_ ja (synopsis x y z ...) rest ...)
     (cons
      (def (synopsis y z ...))
      (def ja rest ...)))
	((_ ((procedure (name arg ...) ...) (p ...) z ...))
     (list
      (html:h3 (html:span :class "type" "procedure") ": "
               (html:span :class "procedure" (html-escape-string (symbol->string 'name))) " "
               (cons (html:span :class "argument" 'arg) " ") ...)
      ...
      (map
       (lambda (x)
         (if (string? x)
             (html:p (html-escape-string x))
             (html:pre (html-escape-string (list-ref '(z ...) x)))))
       (list p ...))
      (html:hr)))
	((_ ((method (name arg ...) ...) (p ...) z ...))
	 (list
	  (html:h3 (html:span :class "type" "method") ": "
			   (html:span :class "method" (html-escape-string (symbol->string 'name))) " "
			   (cons (html:span :class "argument" (html-escape-string (x->string 'arg))) " ") ...)
	  ...
      (map
       (lambda (x)
         (if (string? x)
             (html:p (html-escape-string x))
             (html:pre (html-escape-string (list-ref '(z ...) x)))))
       (list p ...))
	  (html:hr)))
	((_ ((type name ...) (p ...) z ...))
	 (list
	  (html:h3 (html:span :class "type" 'type) ": "
			   (html:span :class 'type (html-escape-string (symbol->string 'name))))
	  ...
      (map
       (lambda (x)
         (if (string? x)
             (html:p (html-escape-string x))
             (html:pre (html-escape-string (list-ref '(z ...) x)))))
       (list p ...))
	  (html:hr)))))

(define-macro (api-libavcodec lang)
  `(def ,lang

	   ((class <avcodec-context>)
		("Each instance of the class has a pointer to its own AVCodecContext.")
		("各インスタンスは AVCodecContext へのポインタを持ちます。"))

	   ((method (close-input-avcodec (c <avcodec-context>)))
		("Close the <avcodec-context> `c'. GC will do that finally even if you leave it open.")
		("<avcodec-context> `c' を閉じます。そのままにしておくと gc が最終的に閉じます。"))

	   ((procedure (avcodec-version))
		("Return the libavcodec's version, e.g. \"51.27.0\".")
		("libavcodec のバージョン(例: \"51.27.0\")を文字列として返します。"))

	   ((method (get-bit-rate (c <avcodec-context>)))
		("(For audio only) Return the bit rate of `c'.")
		("(オーディオのみ) `c' のビットレートを返します。"))

	   ((method (get-sample-rate (c <avcodec-context>)))
		("(For audio only) Return the sample rate of `c'.")
		("(オーディオのみ) `c' のサンプルレートを返します。"))

	   ((method (get-width (c <avcodec-context>)))
		("(For video only) Return the width of `c'.")
		("(ビデオのみ) `c' の横幅を返します。"))

	   ((method (get-height (c <avcodec-context>)))
		("(For video only) Return the height of `c'.")
		("(ビデオのみ) `c' の縦幅を返します。"))

	   ((method (get-codec-name (c <avcodec-context>)))
		("Return its codec name as a string, or #f if failed.")
		("コーデックの名前を文字列で返します。名前が取得できない場合は #f を返します。"))
	   ))

(define-macro (api-libavformat lang)
  `(def ,lang

	   ((class <avformat-context>)
		("Each instance of the class has a pointer to its own AVFormatContext.")
		("各インスタンスは AVFormatContext へのポインタを持ちます。"))

	   ((procedure (avformat-version))
		("Return the libavformat's version, e.g. \"51.6.0\".")
		("libavformat のバージョン(例: \"51.6.0\")を文字列として返します。"))

	   ((method (open-input-avformat (path <string>)))
		("Open and return a <avformat-context> of the av file of path `path', or #f if falied.")
		("`path' にあるファイルを新たに開き <avformat-context> を返します。失敗した場合には #f を返します。"))

	   ((method (close-input-avformat (c <avformat-context>)))
		("Close a <avformat-context> `c'. GC will do that after all if you do not care.")
		("`c' を閉じます。開かれた <avformat-context> をそのままにしておくと GC によって閉じられます。"))

	   ((method (get-duration (c <avformat-context>)))
		("Return the number of seconds in duration of `c'")
		("`c' の再生時間を秒単位で返します。"))

	   ((method (get-file-name (c <avformat-context>)))
		("Return the plain name of the media file of `c', or #f if failed.")
		("`c' のメディアファイルのファイル名を返します。ファイル名が取得できない場合は #f を返します。"))

	   ((procedure (call-with-input-avformat path proc))
		("Call `proc' with a <avformat-context>, which newly open the file of path `path', as a single argument, and return the value `proc' does in case of success."
		 "The <avformat-context> will be closed before the procedure returns with an error or without.")
		("`path' にあるファイルを新たに開き、その <avformat-context> を唯一の引数として `proc' を呼びます。成功した場合には `proc' が返した値を返します。"
		 "この手続きから戻る前にその <avformat-context> は閉じられます。"))
	   ))

(define-macro (api-libavdevice lang)
  `(def ,lang
        ((procedure (avdevice-version))
         ("Return the libavdevice's version, e.g. \"52.0.0\".")
         ("libavdevice のバージョン(例: \"52.0.0\")を文字列として返します。"))
        ))

(define-macro (api-ffmpeg lang)
  `(def ,lang
		((method (open-input-acodec (c <avformat-context>))
				 (open-input-vcodec (c <avformat-context>))
				 (open-input-avcodec (c <avformat-context>)))
		 ("The first form opens and returns a audio <avcodec-context> from `c'. The second one does a video <avcodec-context>. And the last simultaneously returns both values i.e. audio and video codec contexts in that order."
		  "Any of them returns #f if failed.")
		 ("最初のメソッドは `c' からオーディオの <avcodec-context> を開いて返します。2番目は同じようにビデオの <avcodec-context> を返します。そして最後は同時にオーディオ、ビデオ両方の値をこの順番で返します。"
		  "失敗した場合はいずれも #f を返します。"))

		((method (get-frame-rate (fc <avformat-context>) (cc <avcodec-context>)))
		 ("Return two numbers: the numerator and denominator of the frame rate of video with `fc' and `cc'."
		  "Given `cc' must be a video context."
		  "Note: the mothod will be not idempotent (currently at least) since it may occur a side effect for `fc'.")
		 ("フレームレートの分子と分母の2つの数値を返します。"
		  "与えられる`cc' はビデオの context でなければなりません。"
		  "注意: このメソッドは(少なくとも現時点では)繰り返し呼び出すと安全でないかもしれません。"))

		((procedure (call-with-input-avcodec fc proc))
		 ("Call `proc' with the following two arguments: an audio <avcodec-context> and video <avcodec-context>, which are newly opened from `fc'."
		  "Return the value `proc' does in case of success. The <avcodec-context>s will be closed before the procedure returns with an error or without.")
		 ("`proc' を次の2つの引数とともに呼びます: `fc' から開いた(1)オーディオの <avcodec-context> と(2)ビデオの <avcodec-context>。"
		  "成功した場合この手続きは `proc' の戻り値を戻します。開かれた context は手続きから戻る前に閉じられます。"))
		))

(define (document-tree lang)
  (let ((title (if (eq? 'ja lang) "Gauche-ffmpeg リファレンスマニュアル" "Gauche-ffmpeg Reference Manual")))
	(html:html
	 (html:head
	  (if (eq? 'ja lang) (html:meta :http-equiv "Content-Type" :content "text/html; charset=UTF-8") '())
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
		  (html:p (html:span :style "color:red;" "警告:") " 今後変更の可能性があります。"))
	  (html:h2 "API for libavcodec")
	  (if (eq? 'en lang)
		  (api-libavcodec en)
		  (api-libavcodec ja))
	  (html:h2 "API for libavformat")
	  (if (eq? 'en lang)
		  (api-libavformat en)
		  (api-libavformat ja))
      (html:h2 "API for libavdevice")
      (if (eq? 'en lang)
          (api-libavdevice en)
          (api-libavdevice ja))
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
