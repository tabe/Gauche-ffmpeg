#!/usr/bin/env gosh
;; -*- mode: scheme; coding: euc-jp -*-

(use fixedpoint.package)
(use fixedpoint.site)
(use text.html-lite)

(//
 (ffmpeg-php "http://ffmpeg-php.sourceforge.net/")
 (rmovie "http://rmovie.rubyforge.org/")
 (FFmpeg::Command "http://search.cpan.org/~mizzy/FFmpeg-Command-0.07/lib/FFmpeg/Command.pm")
 )

(define-package Gauche-ffmpeg 2008 1 23)

(define-index Gauche-ffmpeg
  (html:p (html:dfn /Gauche-ffmpeg/)
          (en/ja
           (list " is an extension package of " /Gauche/ " which provides a binding of " /ffmpeg/ ".")
           (list " �� " /Scheme/ " ������ " /Gauche/ " �� " /ffmpeg/ " �����Ѥ��뤿��γ�ĥ�ѥå������Ǥ���")))
  (en/ja '()
         (html:p "ffmpeg ���̤ˤĤ��Ƥ����ܸ�ξ����" (html:a :href "/ffmpeg/" "�̥ڡ���") "�ˤޤȤ�Ƥ��ޤ���"))

  (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "News" "�ǿ�����"))
  (html:ul
   (html:li "[2008-01-23] " (en/ja "Release 0.2.0. Introduced liavdevice."
                                   "�С������ 0.2.0 ��������ޤ�����libavdevice ��Ƴ�����ޤ�����"))
   (html:li "[2007-11-01] " (en/ja "It is confirmed that the current version 0.1.1 runs on Gauche 0.8.12."
                                  "Gauche 0.8.12 �Ǹ��ߤΥС������ 0.1.1 ��ư��뤳�Ȥ��ǧ���ޤ�����"))
   (html:li "[2007-05-08] " (en/ja "Release 0.1.1, which now runs on Gauche 0.8.10."
                                   "�С������ 0.1.1 ��������ޤ�����Gauche 0.8.10 ��ư��ޤ���"))
   (html:li "[2007-01-18] " (en/ja "It is confirmed that the current version 0.1.0 runs on Gauche 0.8.9."
                                   "Gauche 0.8.9 �Ǹ��ߤΥС������ 0.1.0 ��ư��뤳�Ȥ��ǧ���ޤ�����"))
   (html:li "[2006-12-07] " (en/ja "Release 0.1.0." "�С������ 0.1.0 ��������ޤ�����")))

  (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Features" "��ħ"))
  (html:ul
   (html:li (en/ja "some descriptions on media files."
                   "��ǥ����ե�����ξ���μ�����"))
   (html:li (en/ja "accessors of libavcodec/libavformat/libavdevice version info."
                   "libavcodec/libavformat/libavdevice �ΥС���������ؤΥ���������"))
   )

  (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Requirements" "Ƴ��"))
  (html:p (en/ja "This package is for Gauche 0.8.12 or later."
                 "���Υѥå������� Gauche 0.8.12 �ޤ��Ϥ���ʾ��ư��ޤ���"))
  (html:ul
   (html:li (en/ja (list "It requires the current SVN release of " /ffmpeg/ " which has been installed as a shared library.")
                   (list "�ޤ����ӡ����ߤ� SVN ��꡼���� " /ffmpeg/ " �ζ�ͭ�饤�֥�꤬���󥹥ȡ��뤵��Ƥ���ɬ�פ�����ޤ���"))))

  (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "License" "�饤����"))
  (html:p "GNU Lesser General Public License, Version 2.1")

  (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Download" "���������"))
  (*package-download*)

  (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Documentation" "ʸ��"))
  (html:ul
   (html:li (html:a :href (en/ja "reference.en.html" "reference.ja.html")
                    "Gauche-ffmpeg " (en/ja "Reference Manual" "��ե���󥹥ޥ˥奢��"))))

  (html:h2 :stle "border-bottom: 1px solid #bbbbbb;" (en/ja "Known Issues" "���Τ�����"))
  (html:ul
   (html:li (en/ja "Loading the modules are not thread safe."
                   "�⥸�塼����ɤ߹��ߤϥ���åɥ����դǤϤ���ޤ���"))
   )

  (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Links" "���"))
  (html:ul
   (html:li /ffmpeg/)
   (html:li /ffmpeg-php/)
   (html:li /rmovie/)
   (html:li /FFmpeg::Command/)
   )
  )

(define main package-main)
