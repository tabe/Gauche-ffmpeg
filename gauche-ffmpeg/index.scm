#!/usr/bin/env gosh

(use file.util)
(use fixedpoint.site)
(use text.html-lite)
(use text.tree)

(//
 (ffmpeg-php "http://ffmpeg-php.sourceforge.net/")
 (rmovie "http://rmovie.rubyforge.org/")
 (FFmpeg::Command "http://search.cpan.org/~mizzy/FFmpeg-Command-0.06/lib/FFmpeg/Command.pm")
 )

(define *last-update* "Tue May 08 2007")
(define *gauche-ffmpeg-version* (file->string "../VERSION"))
(define *gauche-ffmpeg-tarball-basename* (string-append "Gauche-ffmpeg-" *gauche-ffmpeg-version* ".tgz"))
(define *gauche-ffmpeg-tarball-size* (file-size (string-append "../../" *gauche-ffmpeg-tarball-basename*)))
(define *gauche-ffmpeg-tarball-url* *gauche-ffmpeg-tarball-basename*)

(define (index lang)
  (let-syntax ((en/ja (syntax-rules ()
						((_ en ja)
						 (if (string=? "en" lang) en ja)))))
	((fixedpoint:frame "Gauche-ffmpeg")
	 (html:p :id "lang_navi" (html:a :href (en/ja "index.html" "index.en.html")
										"[" (en/ja "Japanese" "English") "]"))
	 (html:p :id "last_update" "Last update: " *last-update*)
	 (fixedpoint:separator)
	 (fixedpoint:adsense)
	 (fixedpoint:separator)
	 (html:p (html:dfn /Gauche-ffmpeg/)
			 (en/ja
				 (list " is an extension package of " /Gauche/ " which provides a binding of " /ffmpeg/ ".")
				 (list " �� " /Scheme/ " ������ " /Gauche/ " �� " /ffmpeg/ " �����Ѥ��뤿��γ�ĥ�ѥå������Ǥ���")))
	 (en/ja '()
			(html:p "ffmpeg ���̤ˤĤ��Ƥ����ܸ�ξ����" (html:a :href "/ffmpeg/" "�̥ڡ���") "�ˤޤȤ�Ƥ��ޤ���"))

	 (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "News" "�ǿ�����"))
	 (html:ul
	  (html:li "[2007-05-08] " (en/ja "Release 0.1.1, which now runs on Gauche 0.8.10."
									  "�С������ 0.1.1 ��������ޤ�����Gauche 0.8.10 ��ư��ޤ���"))
	  (html:li "[2007-01-18] " (en/ja "It is confirmed that the current version 0.1.0 runs on Gauche 0.8.9."
									  "Gauche 0.8.9 �Ǹ��ߤΥС������ 0.1.0 ��ư��뤳�Ȥ��ǧ���ޤ�����"))
	  (html:li "[2006-12-07] " (en/ja "Release 0.1.0." "�С������ 0.1.0 ��������ޤ�����")))

	 (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Features" "��ħ"))
	 (html:ul
	  (html:li (en/ja "some descriptions on media files."
					  "��ǥ����ե�����ξ���μ�����"))
	  (html:li (en/ja "accessors of libavcodec/libavformat version info."
					  "libavcodec/libavformat �ΥС���������ؤΥ���������"))
	  )

	 (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Requirements" "Ƴ��"))
	 (html:p (en/ja "This package is for Gauche 0.8.7 or later."
					"���Υѥå������� Gauche 0.8.7 �ޤ��Ϥ���ʾ��ư��ޤ���"))
	 (html:ul
	  (html:li (en/ja (list "It requires the current SVN release of " /ffmpeg/ " which has been installed with a shared library option.")
					  (list "�ޤ����ӡ����ߤ� SVN ��꡼���� " /ffmpeg/ " �ζ�ͭ�饤�֥�꤬���󥹥ȡ��뤵��Ƥ���ɬ�פ�����ޤ���"))))

	 (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Download" "���������"))
	 (html:p (html:a :href *gauche-ffmpeg-tarball-url*
					 *gauche-ffmpeg-tarball-basename* " (" *gauche-ffmpeg-tarball-size*  " bytes)"))

	 (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Documents" "ʸ��"))
	 (html:ul
	  (html:li (html:a :href (en/ja "reference.en.html" "reference.ja.html")
					   "Gauche-ffmpeg " (en/ja "Reference Manual" "��ե���󥹥ޥ˥奢��"))))

	 (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Links" "���"))
	 (html:ul
	  (html:li /ffmpeg/)
	  (html:li /ffmpeg-php/)
	  (html:li /rmovie/)
	  (html:li /FFmpeg::Command/)
	  )
	 )))

(define (main args)
  (define (usage)
	(format (current-error-port) "usage: gosh ~a (en|ja)\n" *program-name*)
	(exit 1))
  (when (< (length args) 2)
	(usage))
  (write-tree (index (cadr args)))
  0)
