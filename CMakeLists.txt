cmake_minimum_required(VERSION 3.0)

set(CMAKE_CXX_STANDARD 11)

# based on pdfium/BUILD.gn, pdfium/third_party/BUILD.gn, pdfium/third_party/zlib/BUILD.gn, pdfium/v8/BUILD.gn

option(ENABLE_V8 "Build with v8 enabled")
option(V8_USE_SNAPSHOT "Use shapshot")
option(V8_USE_EXTERNAL_SNAPSHOT "Use external snapshot")

# don't use external snapshots for now
# for some reason, mksnapshot generates corrupted snapshot blobs which cannot be read by (static) v8

message("V8 enabled: " ${ENABLE_V8})
if(${ENABLE_V8})
    message("Use snapshot: " ${V8_USE_SNAPSHOT})
endif()
if(${V8_USE_EXTERNAL_SNAPSHOT})
    message(WARNING "External snapshots are currently not supported by this build, they cause v8 to crash")
endif()

if(CMAKE_SYSTEM_NAME MATCHES "Linux")
    set(LINUX TRUE)
endif()

# TODO add XFA, Skia support, enable build config (similar to gn args)
# TODO on Linux, -D_FX_CPU_=_FX_X64_ or -D_FX_CPU_=_FX_X86_
# TODO on Windows, add these to CFLAGS: /utf-8 /wd4267 /wd4324 /wd4577

# on Mac: brew install libjpg zlib libpng icu4c
find_package(JPEG REQUIRED)
find_package(ZLIB REQUIRED)
find_package(PNG REQUIRED)

set(PDFIUM_SRC
    fpdfsdk/cba_annotiterator.cpp
    fpdfsdk/cba_annotiterator.h
    fpdfsdk/cfx_systemhandler.cpp
    fpdfsdk/cfx_systemhandler.h
    fpdfsdk/cpdfsdk_annot.cpp
    fpdfsdk/cpdfsdk_annot.h
    fpdfsdk/cpdfsdk_annothandlermgr.cpp
    fpdfsdk/cpdfsdk_annothandlermgr.h
    fpdfsdk/cpdfsdk_annotiteration.cpp
    fpdfsdk/cpdfsdk_annotiteration.h
    fpdfsdk/cpdfsdk_baannot.cpp
    fpdfsdk/cpdfsdk_baannot.h
    fpdfsdk/cpdfsdk_baannothandler.cpp
    fpdfsdk/cpdfsdk_baannothandler.h
    fpdfsdk/cpdfsdk_datetime.cpp
    fpdfsdk/cpdfsdk_datetime.h
    fpdfsdk/cpdfsdk_formfillenvironment.cpp
    fpdfsdk/cpdfsdk_formfillenvironment.h
    fpdfsdk/cpdfsdk_interform.cpp
    fpdfsdk/cpdfsdk_interform.h
    fpdfsdk/cpdfsdk_pageview.cpp
    fpdfsdk/cpdfsdk_pageview.h
    fpdfsdk/cpdfsdk_widget.cpp
    fpdfsdk/cpdfsdk_widget.h
    fpdfsdk/cpdfsdk_widgethandler.cpp
    fpdfsdk/cpdfsdk_widgethandler.h
    fpdfsdk/fpdf_dataavail.cpp
    fpdfsdk/fpdf_ext.cpp
    fpdfsdk/fpdf_flatten.cpp
    fpdfsdk/fpdf_progressive.cpp
    fpdfsdk/fpdf_searchex.cpp
    fpdfsdk/fpdf_structtree.cpp
    fpdfsdk/fpdf_sysfontinfo.cpp
    fpdfsdk/fpdf_transformpage.cpp
    fpdfsdk/fpdfannot.cpp
    fpdfsdk/fpdfattachment.cpp
    fpdfsdk/fpdfdoc.cpp
    fpdfsdk/fpdfeditimg.cpp
    fpdfsdk/fpdfeditpage.cpp
    fpdfsdk/fpdfeditpath.cpp
    fpdfsdk/fpdfedittext.cpp
    fpdfsdk/fpdfformfill.cpp
    fpdfsdk/fpdfppo.cpp
    fpdfsdk/fpdfsave.cpp
    fpdfsdk/fpdftext.cpp
    fpdfsdk/fpdfview.cpp
    fpdfsdk/fsdk_actionhandler.cpp
    fpdfsdk/fsdk_actionhandler.h
    fpdfsdk/fsdk_filewriteadapter.cpp
    fpdfsdk/fsdk_filewriteadapter.h
    fpdfsdk/fsdk_pauseadapter.cpp
    fpdfsdk/fsdk_pauseadapter.h
    fpdfsdk/pdfsdk_fieldaction.cpp
    fpdfsdk/pdfsdk_fieldaction.h
    public/cpp/fpdf_deleters.h
    public/fpdf_annot.h
    public/fpdf_attachment.h
    public/fpdf_dataavail.h
    public/fpdf_doc.h
    public/fpdf_edit.h
    public/fpdf_ext.h
    public/fpdf_flatten.h
    public/fpdf_formfill.h
    public/fpdf_fwlevent.h
    public/fpdf_ppo.h
    public/fpdf_progressive.h
    public/fpdf_save.h
    public/fpdf_searchex.h
    public/fpdf_structtree.h
    public/fpdf_sysfontinfo.h
    public/fpdf_text.h
    public/fpdf_transformpage.h
    public/fpdfview.h
) # PDFIUM_SRC

set(FDRM_SRC
    core/fdrm/crypto/fx_crypt.cpp
    core/fdrm/crypto/fx_crypt.h
    core/fdrm/crypto/fx_crypt_aes.cpp
    core/fdrm/crypto/fx_crypt_sha.cpp
) # FDRM_SRC

set(FPDFDOC_SRC
    core/fpdfdoc/cline.cpp
    core/fpdfdoc/cline.h
    core/fpdfdoc/cpdf_aaction.cpp
    core/fpdfdoc/cpdf_aaction.h
    core/fpdfdoc/cpdf_action.cpp
    core/fpdfdoc/cpdf_action.h
    core/fpdfdoc/cpdf_actionfields.cpp
    core/fpdfdoc/cpdf_actionfields.h
    core/fpdfdoc/cpdf_annot.cpp
    core/fpdfdoc/cpdf_annot.h
    core/fpdfdoc/cpdf_annotlist.cpp
    core/fpdfdoc/cpdf_annotlist.h
    core/fpdfdoc/cpdf_apsettings.cpp
    core/fpdfdoc/cpdf_apsettings.h
    core/fpdfdoc/cpdf_bookmark.cpp
    core/fpdfdoc/cpdf_bookmark.h
    core/fpdfdoc/cpdf_bookmarktree.cpp
    core/fpdfdoc/cpdf_bookmarktree.h
    core/fpdfdoc/cpdf_defaultappearance.cpp
    core/fpdfdoc/cpdf_defaultappearance.h
    core/fpdfdoc/cpdf_dest.cpp
    core/fpdfdoc/cpdf_dest.h
    core/fpdfdoc/cpdf_docjsactions.cpp
    core/fpdfdoc/cpdf_docjsactions.h
    core/fpdfdoc/cpdf_filespec.cpp
    core/fpdfdoc/cpdf_filespec.h
    core/fpdfdoc/cpdf_formcontrol.cpp
    core/fpdfdoc/cpdf_formcontrol.h
    core/fpdfdoc/cpdf_formfield.cpp
    core/fpdfdoc/cpdf_formfield.h
    core/fpdfdoc/cpdf_iconfit.cpp
    core/fpdfdoc/cpdf_iconfit.h
    core/fpdfdoc/cpdf_interform.cpp
    core/fpdfdoc/cpdf_interform.h
    core/fpdfdoc/cpdf_link.cpp
    core/fpdfdoc/cpdf_link.h
    core/fpdfdoc/cpdf_linklist.cpp
    core/fpdfdoc/cpdf_linklist.h
    core/fpdfdoc/cpdf_metadata.cpp
    core/fpdfdoc/cpdf_metadata.h
    core/fpdfdoc/cpdf_nametree.cpp
    core/fpdfdoc/cpdf_nametree.h
    core/fpdfdoc/cpdf_numbertree.cpp
    core/fpdfdoc/cpdf_numbertree.h
    core/fpdfdoc/cpdf_occontext.cpp
    core/fpdfdoc/cpdf_occontext.h
    core/fpdfdoc/cpdf_pagelabel.cpp
    core/fpdfdoc/cpdf_pagelabel.h
    core/fpdfdoc/cpdf_structelement.cpp
    core/fpdfdoc/cpdf_structelement.h
    core/fpdfdoc/cpdf_structtree.cpp
    core/fpdfdoc/cpdf_structtree.h
    core/fpdfdoc/cpdf_variabletext.cpp
    core/fpdfdoc/cpdf_variabletext.h
    core/fpdfdoc/cpdf_viewerpreferences.cpp
    core/fpdfdoc/cpdf_viewerpreferences.h
    core/fpdfdoc/cpvt_floatrect.h
    core/fpdfdoc/cpvt_fontmap.cpp
    core/fpdfdoc/cpvt_fontmap.h
    core/fpdfdoc/cpvt_generateap.cpp
    core/fpdfdoc/cpvt_generateap.h
    core/fpdfdoc/cpvt_line.h
    core/fpdfdoc/cpvt_lineinfo.h
    core/fpdfdoc/cpvt_word.h
    core/fpdfdoc/cpvt_wordinfo.cpp
    core/fpdfdoc/cpvt_wordinfo.h
    core/fpdfdoc/cpvt_wordplace.h
    core/fpdfdoc/cpvt_wordrange.h
    core/fpdfdoc/csection.cpp
    core/fpdfdoc/csection.h
    core/fpdfdoc/ctypeset.cpp
    core/fpdfdoc/ctypeset.h
    core/fpdfdoc/ipdf_formnotify.h
    core/fpdfdoc/ipvt_fontmap.h
) # FPDFDOC_SRC

set(FPDFAPI_SRC
    core/fpdfapi/cmaps/CNS1/Adobe-CNS1-UCS2_5.cpp
    core/fpdfapi/cmaps/CNS1/B5pc-H_0.cpp
    core/fpdfapi/cmaps/CNS1/B5pc-V_0.cpp
    core/fpdfapi/cmaps/CNS1/CNS-EUC-H_0.cpp
    core/fpdfapi/cmaps/CNS1/CNS-EUC-V_0.cpp
    core/fpdfapi/cmaps/CNS1/ETen-B5-H_0.cpp
    core/fpdfapi/cmaps/CNS1/ETen-B5-V_0.cpp
    core/fpdfapi/cmaps/CNS1/ETenms-B5-H_0.cpp
    core/fpdfapi/cmaps/CNS1/ETenms-B5-V_0.cpp
    core/fpdfapi/cmaps/CNS1/HKscs-B5-H_5.cpp
    core/fpdfapi/cmaps/CNS1/HKscs-B5-V_5.cpp
    core/fpdfapi/cmaps/CNS1/UniCNS-UCS2-H_3.cpp
    core/fpdfapi/cmaps/CNS1/UniCNS-UCS2-V_3.cpp
    core/fpdfapi/cmaps/CNS1/UniCNS-UTF16-H_0.cpp
    core/fpdfapi/cmaps/CNS1/cmaps_cns1.cpp
    core/fpdfapi/cmaps/GB1/Adobe-GB1-UCS2_5.cpp
    core/fpdfapi/cmaps/GB1/GB-EUC-H_0.cpp
    core/fpdfapi/cmaps/GB1/GB-EUC-V_0.cpp
    core/fpdfapi/cmaps/GB1/GBK-EUC-H_2.cpp
    core/fpdfapi/cmaps/GB1/GBK-EUC-V_2.cpp
    core/fpdfapi/cmaps/GB1/GBK2K-H_5.cpp
    core/fpdfapi/cmaps/GB1/GBK2K-V_5.cpp
    core/fpdfapi/cmaps/GB1/GBKp-EUC-H_2.cpp
    core/fpdfapi/cmaps/GB1/GBKp-EUC-V_2.cpp
    core/fpdfapi/cmaps/GB1/GBpc-EUC-H_0.cpp
    core/fpdfapi/cmaps/GB1/GBpc-EUC-V_0.cpp
    core/fpdfapi/cmaps/GB1/UniGB-UCS2-H_4.cpp
    core/fpdfapi/cmaps/GB1/UniGB-UCS2-V_4.cpp
    core/fpdfapi/cmaps/GB1/cmaps_gb1.cpp
    core/fpdfapi/cmaps/Japan1/83pv-RKSJ-H_1.cpp
    core/fpdfapi/cmaps/Japan1/90ms-RKSJ-H_2.cpp
    core/fpdfapi/cmaps/Japan1/90ms-RKSJ-V_2.cpp
    core/fpdfapi/cmaps/Japan1/90msp-RKSJ-H_2.cpp
    core/fpdfapi/cmaps/Japan1/90msp-RKSJ-V_2.cpp
    core/fpdfapi/cmaps/Japan1/90pv-RKSJ-H_1.cpp
    core/fpdfapi/cmaps/Japan1/Add-RKSJ-H_1.cpp
    core/fpdfapi/cmaps/Japan1/Add-RKSJ-V_1.cpp
    core/fpdfapi/cmaps/Japan1/Adobe-Japan1-UCS2_4.cpp
    core/fpdfapi/cmaps/Japan1/EUC-H_1.cpp
    core/fpdfapi/cmaps/Japan1/EUC-V_1.cpp
    core/fpdfapi/cmaps/Japan1/Ext-RKSJ-H_2.cpp
    core/fpdfapi/cmaps/Japan1/Ext-RKSJ-V_2.cpp
    core/fpdfapi/cmaps/Japan1/H_1.cpp
    core/fpdfapi/cmaps/Japan1/UniJIS-UCS2-HW-H_4.cpp
    core/fpdfapi/cmaps/Japan1/UniJIS-UCS2-HW-V_4.cpp
    core/fpdfapi/cmaps/Japan1/UniJIS-UCS2-H_4.cpp
    core/fpdfapi/cmaps/Japan1/UniJIS-UCS2-V_4.cpp
    core/fpdfapi/cmaps/Japan1/V_1.cpp
    core/fpdfapi/cmaps/Japan1/cmaps_japan1.cpp
    core/fpdfapi/cmaps/Korea1/Adobe-Korea1-UCS2_2.cpp
    core/fpdfapi/cmaps/Korea1/KSC-EUC-H_0.cpp
    core/fpdfapi/cmaps/Korea1/KSC-EUC-V_0.cpp
    core/fpdfapi/cmaps/Korea1/KSCms-UHC-HW-H_1.cpp
    core/fpdfapi/cmaps/Korea1/KSCms-UHC-HW-V_1.cpp
    core/fpdfapi/cmaps/Korea1/KSCms-UHC-H_1.cpp
    core/fpdfapi/cmaps/Korea1/KSCms-UHC-V_1.cpp
    core/fpdfapi/cmaps/Korea1/KSCpc-EUC-H_0.cpp
    core/fpdfapi/cmaps/Korea1/UniKS-UCS2-H_1.cpp
    core/fpdfapi/cmaps/Korea1/UniKS-UCS2-V_1.cpp
    core/fpdfapi/cmaps/Korea1/UniKS-UTF16-H_0.cpp
    core/fpdfapi/cmaps/Korea1/cmaps_korea1.cpp
    core/fpdfapi/cmaps/cmap_int.h
    core/fpdfapi/cmaps/fpdf_cmaps.cpp
    core/fpdfapi/cpdf_modulemgr.cpp
    core/fpdfapi/cpdf_modulemgr.h
    core/fpdfapi/cpdf_pagerendercontext.cpp
    core/fpdfapi/cpdf_pagerendercontext.h
    core/fpdfapi/edit/cpdf_creator.cpp
    core/fpdfapi/edit/cpdf_creator.h
    core/fpdfapi/edit/cpdf_encryptor.cpp
    core/fpdfapi/edit/cpdf_encryptor.h
    core/fpdfapi/edit/cpdf_flateencoder.cpp
    core/fpdfapi/edit/cpdf_flateencoder.h
    core/fpdfapi/edit/cpdf_pagecontentgenerator.cpp
    core/fpdfapi/edit/cpdf_pagecontentgenerator.h
    core/fpdfapi/font/cfx_cttgsubtable.cpp
    core/fpdfapi/font/cfx_cttgsubtable.h
    core/fpdfapi/font/cfx_stockfontarray.cpp
    core/fpdfapi/font/cfx_stockfontarray.h
    core/fpdfapi/font/cpdf_cid2unicodemap.cpp
    core/fpdfapi/font/cpdf_cid2unicodemap.h
    core/fpdfapi/font/cpdf_cidfont.cpp
    core/fpdfapi/font/cpdf_cidfont.h
    core/fpdfapi/font/cpdf_cmap.cpp
    core/fpdfapi/font/cpdf_cmap.h
    core/fpdfapi/font/cpdf_cmapmanager.cpp
    core/fpdfapi/font/cpdf_cmapmanager.h
    core/fpdfapi/font/cpdf_cmapparser.cpp
    core/fpdfapi/font/cpdf_cmapparser.h
    core/fpdfapi/font/cpdf_font.cpp
    core/fpdfapi/font/cpdf_font.h
    core/fpdfapi/font/cpdf_fontencoding.cpp
    core/fpdfapi/font/cpdf_fontencoding.h
    core/fpdfapi/font/cpdf_fontglobals.cpp
    core/fpdfapi/font/cpdf_fontglobals.h
    core/fpdfapi/font/cpdf_simplefont.cpp
    core/fpdfapi/font/cpdf_simplefont.h
    core/fpdfapi/font/cpdf_tounicodemap.cpp
    core/fpdfapi/font/cpdf_tounicodemap.h
    core/fpdfapi/font/cpdf_truetypefont.cpp
    core/fpdfapi/font/cpdf_truetypefont.h
    core/fpdfapi/font/cpdf_type1font.cpp
    core/fpdfapi/font/cpdf_type1font.h
    core/fpdfapi/font/cpdf_type3char.cpp
    core/fpdfapi/font/cpdf_type3char.h
    core/fpdfapi/font/cpdf_type3font.cpp
    core/fpdfapi/font/cpdf_type3font.h
    core/fpdfapi/page/cpdf_allstates.cpp
    core/fpdfapi/page/cpdf_allstates.h
    core/fpdfapi/page/cpdf_clippath.cpp
    core/fpdfapi/page/cpdf_clippath.h
    core/fpdfapi/page/cpdf_color.cpp
    core/fpdfapi/page/cpdf_color.h
    core/fpdfapi/page/cpdf_colorspace.cpp
    core/fpdfapi/page/cpdf_colorspace.h
    core/fpdfapi/page/cpdf_colorstate.cpp
    core/fpdfapi/page/cpdf_colorstate.h
    core/fpdfapi/page/cpdf_contentmark.cpp
    core/fpdfapi/page/cpdf_contentmark.h
    core/fpdfapi/page/cpdf_contentmarkitem.cpp
    core/fpdfapi/page/cpdf_contentmarkitem.h
    core/fpdfapi/page/cpdf_contentparser.cpp
    core/fpdfapi/page/cpdf_contentparser.h
    core/fpdfapi/page/cpdf_countedobject.h
    core/fpdfapi/page/cpdf_devicecs.cpp
    core/fpdfapi/page/cpdf_devicecs.h
    core/fpdfapi/page/cpdf_docpagedata.cpp
    core/fpdfapi/page/cpdf_docpagedata.h
    core/fpdfapi/page/cpdf_expintfunc.cpp
    core/fpdfapi/page/cpdf_expintfunc.h
    core/fpdfapi/page/cpdf_form.cpp
    core/fpdfapi/page/cpdf_form.h
    core/fpdfapi/page/cpdf_formobject.cpp
    core/fpdfapi/page/cpdf_formobject.h
    core/fpdfapi/page/cpdf_function.cpp
    core/fpdfapi/page/cpdf_function.h
    core/fpdfapi/page/cpdf_generalstate.cpp
    core/fpdfapi/page/cpdf_generalstate.h
    core/fpdfapi/page/cpdf_graphicstates.cpp
    core/fpdfapi/page/cpdf_graphicstates.h
    core/fpdfapi/page/cpdf_iccprofile.cpp
    core/fpdfapi/page/cpdf_iccprofile.h
    core/fpdfapi/page/cpdf_image.cpp
    core/fpdfapi/page/cpdf_image.h
    core/fpdfapi/page/cpdf_imageobject.cpp
    core/fpdfapi/page/cpdf_imageobject.h
    core/fpdfapi/page/cpdf_meshstream.cpp
    core/fpdfapi/page/cpdf_meshstream.h
    core/fpdfapi/page/cpdf_page.cpp
    core/fpdfapi/page/cpdf_page.h
    core/fpdfapi/page/cpdf_pagemodule.cpp
    core/fpdfapi/page/cpdf_pagemodule.h
    core/fpdfapi/page/cpdf_pageobject.cpp
    core/fpdfapi/page/cpdf_pageobject.h
    core/fpdfapi/page/cpdf_pageobjectholder.cpp
    core/fpdfapi/page/cpdf_pageobjectholder.h
    core/fpdfapi/page/cpdf_pageobjectlist.cpp
    core/fpdfapi/page/cpdf_pageobjectlist.h
    core/fpdfapi/page/cpdf_path.cpp
    core/fpdfapi/page/cpdf_path.h
    core/fpdfapi/page/cpdf_pathobject.cpp
    core/fpdfapi/page/cpdf_pathobject.h
    core/fpdfapi/page/cpdf_pattern.cpp
    core/fpdfapi/page/cpdf_pattern.h
    core/fpdfapi/page/cpdf_patterncs.cpp
    core/fpdfapi/page/cpdf_patterncs.h
    core/fpdfapi/page/cpdf_psengine.cpp
    core/fpdfapi/page/cpdf_psengine.h
    core/fpdfapi/page/cpdf_psfunc.cpp
    core/fpdfapi/page/cpdf_psfunc.h
    core/fpdfapi/page/cpdf_sampledfunc.cpp
    core/fpdfapi/page/cpdf_sampledfunc.h
    core/fpdfapi/page/cpdf_shadingobject.cpp
    core/fpdfapi/page/cpdf_shadingobject.h
    core/fpdfapi/page/cpdf_shadingpattern.cpp
    core/fpdfapi/page/cpdf_shadingpattern.h
    core/fpdfapi/page/cpdf_stitchfunc.cpp
    core/fpdfapi/page/cpdf_stitchfunc.h
    core/fpdfapi/page/cpdf_streamcontentparser.cpp
    core/fpdfapi/page/cpdf_streamcontentparser.h
    core/fpdfapi/page/cpdf_streamparser.cpp
    core/fpdfapi/page/cpdf_streamparser.h
    core/fpdfapi/page/cpdf_textobject.cpp
    core/fpdfapi/page/cpdf_textobject.h
    core/fpdfapi/page/cpdf_textstate.cpp
    core/fpdfapi/page/cpdf_textstate.h
    core/fpdfapi/page/cpdf_tilingpattern.cpp
    core/fpdfapi/page/cpdf_tilingpattern.h
    core/fpdfapi/parser/cfdf_document.cpp
    core/fpdfapi/parser/cfdf_document.h
    core/fpdfapi/parser/cpdf_array.cpp
    core/fpdfapi/parser/cpdf_array.h
    core/fpdfapi/parser/cpdf_boolean.cpp
    core/fpdfapi/parser/cpdf_boolean.h
    core/fpdfapi/parser/cpdf_cross_ref_avail.cpp
    core/fpdfapi/parser/cpdf_cross_ref_avail.h
    core/fpdfapi/parser/cpdf_crypto_handler.cpp
    core/fpdfapi/parser/cpdf_crypto_handler.h
    core/fpdfapi/parser/cpdf_data_avail.cpp
    core/fpdfapi/parser/cpdf_data_avail.h
    core/fpdfapi/parser/cpdf_dictionary.cpp
    core/fpdfapi/parser/cpdf_dictionary.h
    core/fpdfapi/parser/cpdf_document.cpp
    core/fpdfapi/parser/cpdf_document.h
    core/fpdfapi/parser/cpdf_hint_tables.cpp
    core/fpdfapi/parser/cpdf_hint_tables.h
    core/fpdfapi/parser/cpdf_indirect_object_holder.cpp
    core/fpdfapi/parser/cpdf_indirect_object_holder.h
    core/fpdfapi/parser/cpdf_linearized_header.cpp
    core/fpdfapi/parser/cpdf_linearized_header.h
    core/fpdfapi/parser/cpdf_name.cpp
    core/fpdfapi/parser/cpdf_name.h
    core/fpdfapi/parser/cpdf_null.cpp
    core/fpdfapi/parser/cpdf_null.h
    core/fpdfapi/parser/cpdf_number.cpp
    core/fpdfapi/parser/cpdf_number.h
    core/fpdfapi/parser/cpdf_object.cpp
    core/fpdfapi/parser/cpdf_object.h
    core/fpdfapi/parser/cpdf_object_avail.cpp
    core/fpdfapi/parser/cpdf_object_avail.h
    core/fpdfapi/parser/cpdf_object_walker.cpp
    core/fpdfapi/parser/cpdf_object_walker.h
    core/fpdfapi/parser/cpdf_page_object_avail.cpp
    core/fpdfapi/parser/cpdf_page_object_avail.h
    core/fpdfapi/parser/cpdf_parser.cpp
    core/fpdfapi/parser/cpdf_parser.h
    core/fpdfapi/parser/cpdf_read_validator.cpp
    core/fpdfapi/parser/cpdf_read_validator.h
    core/fpdfapi/parser/cpdf_reference.cpp
    core/fpdfapi/parser/cpdf_reference.h
    core/fpdfapi/parser/cpdf_security_handler.cpp
    core/fpdfapi/parser/cpdf_security_handler.h
    core/fpdfapi/parser/cpdf_simple_parser.cpp
    core/fpdfapi/parser/cpdf_simple_parser.h
    core/fpdfapi/parser/cpdf_stream.cpp
    core/fpdfapi/parser/cpdf_stream.h
    core/fpdfapi/parser/cpdf_stream_acc.cpp
    core/fpdfapi/parser/cpdf_stream_acc.h
    core/fpdfapi/parser/cpdf_string.cpp
    core/fpdfapi/parser/cpdf_string.h
    core/fpdfapi/parser/cpdf_syntax_parser.cpp
    core/fpdfapi/parser/cpdf_syntax_parser.h
    core/fpdfapi/parser/fpdf_parser_decode.cpp
    core/fpdfapi/parser/fpdf_parser_decode.h
    core/fpdfapi/parser/fpdf_parser_utility.cpp
    core/fpdfapi/parser/fpdf_parser_utility.h
    core/fpdfapi/render/cpdf_charposlist.cpp
    core/fpdfapi/render/cpdf_charposlist.h
    core/fpdfapi/render/cpdf_devicebuffer.cpp
    core/fpdfapi/render/cpdf_devicebuffer.h
    core/fpdfapi/render/cpdf_dibsource.cpp
    core/fpdfapi/render/cpdf_dibsource.h
    core/fpdfapi/render/cpdf_dibtransferfunc.cpp
    core/fpdfapi/render/cpdf_dibtransferfunc.h
    core/fpdfapi/render/cpdf_docrenderdata.cpp
    core/fpdfapi/render/cpdf_docrenderdata.h
    core/fpdfapi/render/cpdf_imagecacheentry.cpp
    core/fpdfapi/render/cpdf_imagecacheentry.h
    core/fpdfapi/render/cpdf_imageloader.cpp
    core/fpdfapi/render/cpdf_imageloader.h
    core/fpdfapi/render/cpdf_imagerenderer.cpp
    core/fpdfapi/render/cpdf_imagerenderer.h
    core/fpdfapi/render/cpdf_pagerendercache.cpp
    core/fpdfapi/render/cpdf_pagerendercache.h
    core/fpdfapi/render/cpdf_progressiverenderer.cpp
    core/fpdfapi/render/cpdf_progressiverenderer.h
    core/fpdfapi/render/cpdf_rendercontext.cpp
    core/fpdfapi/render/cpdf_rendercontext.h
    core/fpdfapi/render/cpdf_renderoptions.cpp
    core/fpdfapi/render/cpdf_renderoptions.h
    core/fpdfapi/render/cpdf_renderstatus.cpp
    core/fpdfapi/render/cpdf_renderstatus.h
    core/fpdfapi/render/cpdf_scaledrenderbuffer.cpp
    core/fpdfapi/render/cpdf_scaledrenderbuffer.h
    core/fpdfapi/render/cpdf_textrenderer.cpp
    core/fpdfapi/render/cpdf_textrenderer.h
    core/fpdfapi/render/cpdf_transferfunc.cpp
    core/fpdfapi/render/cpdf_transferfunc.h
    core/fpdfapi/render/cpdf_type3cache.cpp
    core/fpdfapi/render/cpdf_type3cache.h
    core/fpdfapi/render/cpdf_type3glyphs.cpp
    core/fpdfapi/render/cpdf_type3glyphs.h
) # FPDFAPI_SRC

set(FPDFTEXT_SRC
    core/fpdftext/cpdf_linkextract.cpp
    core/fpdftext/cpdf_linkextract.h
    core/fpdftext/cpdf_textpage.cpp
    core/fpdftext/cpdf_textpage.h
    core/fpdftext/cpdf_textpagefind.cpp
    core/fpdftext/cpdf_textpagefind.h
    core/fpdftext/unicodenormalizationdata.cpp
    core/fpdftext/unicodenormalizationdata.h
) # FPDFTEXT_SRC

set(FXCODEC_SRC
    core/fxcodec/JBig2_DocumentContext.h
    core/fxcodec/codec/ccodec_basicmodule.h
    core/fxcodec/codec/ccodec_faxmodule.h
    core/fxcodec/codec/ccodec_flatemodule.h
    core/fxcodec/codec/ccodec_iccmodule.h
    core/fxcodec/codec/ccodec_jbig2module.h
    core/fxcodec/codec/ccodec_jpegmodule.h
    core/fxcodec/codec/ccodec_jpxmodule.h
    core/fxcodec/codec/ccodec_scanlinedecoder.cpp
    core/fxcodec/codec/ccodec_scanlinedecoder.h
    core/fxcodec/codec/cjpx_decoder.h
    core/fxcodec/codec/codec_int.h
    core/fxcodec/codec/fx_codec.cpp
    core/fxcodec/codec/fx_codec_fax.cpp
    core/fxcodec/codec/fx_codec_flate.cpp
    core/fxcodec/codec/fx_codec_icc.cpp
    core/fxcodec/codec/fx_codec_jbig.cpp
    core/fxcodec/codec/fx_codec_jpeg.cpp
    core/fxcodec/codec/fx_codec_jpx_opj.cpp
    core/fxcodec/fx_codec.h
    core/fxcodec/fx_codec_def.h
    core/fxcodec/jbig2/JBig2_ArithDecoder.cpp
    core/fxcodec/jbig2/JBig2_ArithDecoder.h
    core/fxcodec/jbig2/JBig2_ArithIntDecoder.cpp
    core/fxcodec/jbig2/JBig2_ArithIntDecoder.h
    core/fxcodec/jbig2/JBig2_BitStream.cpp
    core/fxcodec/jbig2/JBig2_BitStream.h
    core/fxcodec/jbig2/JBig2_Context.cpp
    core/fxcodec/jbig2/JBig2_Context.h
    core/fxcodec/jbig2/JBig2_Define.h
    core/fxcodec/jbig2/JBig2_GrdProc.cpp
    core/fxcodec/jbig2/JBig2_GrdProc.h
    core/fxcodec/jbig2/JBig2_GrrdProc.cpp
    core/fxcodec/jbig2/JBig2_GrrdProc.h
    core/fxcodec/jbig2/JBig2_HtrdProc.cpp
    core/fxcodec/jbig2/JBig2_HtrdProc.h
    core/fxcodec/jbig2/JBig2_HuffmanDecoder.cpp
    core/fxcodec/jbig2/JBig2_HuffmanDecoder.h
    core/fxcodec/jbig2/JBig2_HuffmanTable.cpp
    core/fxcodec/jbig2/JBig2_HuffmanTable.h
    core/fxcodec/jbig2/JBig2_HuffmanTable_Standard.cpp
    core/fxcodec/jbig2/JBig2_HuffmanTable_Standard.h
    core/fxcodec/jbig2/JBig2_Image.cpp
    core/fxcodec/jbig2/JBig2_Image.h
    core/fxcodec/jbig2/JBig2_Page.h
    core/fxcodec/jbig2/JBig2_PatternDict.cpp
    core/fxcodec/jbig2/JBig2_PatternDict.h
    core/fxcodec/jbig2/JBig2_PddProc.cpp
    core/fxcodec/jbig2/JBig2_PddProc.h
    core/fxcodec/jbig2/JBig2_SddProc.cpp
    core/fxcodec/jbig2/JBig2_SddProc.h
    core/fxcodec/jbig2/JBig2_Segment.cpp
    core/fxcodec/jbig2/JBig2_Segment.h
    core/fxcodec/jbig2/JBig2_SymbolDict.cpp
    core/fxcodec/jbig2/JBig2_SymbolDict.h
    core/fxcodec/jbig2/JBig2_TrdProc.cpp
    core/fxcodec/jbig2/JBig2_TrdProc.h
    # TODO pdf_enable_xfa
) # FXCODEC_SRC

set(FXCRT_SRC
    core/fxcrt/autorestorer.h
    core/fxcrt/bytestring.cpp
    core/fxcrt/bytestring.h
    core/fxcrt/cfx_binarybuf.cpp
    core/fxcrt/cfx_binarybuf.h
    core/fxcrt/cfx_bitstream.cpp
    core/fxcrt/cfx_bitstream.h
    core/fxcrt/cfx_datetime.cpp
    core/fxcrt/cfx_datetime.h
    core/fxcrt/cfx_fileaccess_posix.cpp
    core/fxcrt/cfx_fileaccess_posix.h
    core/fxcrt/cfx_fileaccess_windows.cpp
    core/fxcrt/cfx_fileaccess_windows.h
    core/fxcrt/cfx_fixedbufgrow.h
    core/fxcrt/cfx_memorystream.cpp
    core/fxcrt/cfx_memorystream.h
    core/fxcrt/cfx_utf8decoder.cpp
    core/fxcrt/cfx_utf8decoder.h
    core/fxcrt/cfx_widetextbuf.cpp
    core/fxcrt/cfx_widetextbuf.h
    core/fxcrt/fx_bidi.cpp
    core/fxcrt/fx_bidi.h
    core/fxcrt/fx_codepage.h
    core/fxcrt/fx_coordinates.cpp
    core/fxcrt/fx_coordinates.h
    core/fxcrt/fx_extension.cpp
    core/fxcrt/fx_extension.h
    core/fxcrt/fx_memory.cpp
    core/fxcrt/fx_memory.h
    core/fxcrt/fx_random.cpp
    core/fxcrt/fx_random.h
    core/fxcrt/fx_safe_types.h
    core/fxcrt/fx_stream.cpp
    core/fxcrt/fx_stream.h
    core/fxcrt/fx_string.cpp
    core/fxcrt/fx_string.h
    core/fxcrt/fx_system.cpp
    core/fxcrt/fx_system.h
    core/fxcrt/fx_ucddata.cpp
    core/fxcrt/fx_ucddata.h
    core/fxcrt/fx_unicode.cpp
    core/fxcrt/fx_unicode.h
    core/fxcrt/ifx_fileaccess.h
    core/fxcrt/ifx_pauseindicator.h
    core/fxcrt/maybe_owned.h
    core/fxcrt/observable.h
    core/fxcrt/retain_ptr.h
    core/fxcrt/shared_copy_on_write.h
    core/fxcrt/string_data_template.h
    core/fxcrt/string_pool_template.h
    core/fxcrt/string_view_template.h
    core/fxcrt/unowned_ptr.h
    core/fxcrt/weak_ptr.h
    core/fxcrt/widestring.cpp
    core/fxcrt/widestring.h
    core/fxcrt/xml/cxml_attritem.cpp
    core/fxcrt/xml/cxml_attritem.h
    core/fxcrt/xml/cxml_content.cpp
    core/fxcrt/xml/cxml_content.h
    core/fxcrt/xml/cxml_databufacc.cpp
    core/fxcrt/xml/cxml_databufacc.h
    core/fxcrt/xml/cxml_element.cpp
    core/fxcrt/xml/cxml_element.h
    core/fxcrt/xml/cxml_object.cpp
    core/fxcrt/xml/cxml_object.h
    core/fxcrt/xml/cxml_parser.cpp
    core/fxcrt/xml/cxml_parser.h
    # TODO pdf_enable_xfa
) # FXCRT_SRC

set(FXGE_SRC
    # do NOT add core/fxge/android/* because it will break your fonts (wrong font mgr will be used)
    core/fxge/cfx_cliprgn.cpp
    core/fxge/cfx_cliprgn.h
    core/fxge/cfx_color.cpp
    core/fxge/cfx_color.h
    core/fxge/cfx_defaultrenderdevice.h
    core/fxge/cfx_facecache.cpp
    core/fxge/cfx_facecache.h
    core/fxge/cfx_folderfontinfo.cpp
    core/fxge/cfx_folderfontinfo.h
    core/fxge/cfx_font.cpp
    core/fxge/cfx_fontcache.cpp
    core/fxge/cfx_fontcache.h
    core/fxge/cfx_fontmapper.cpp
    core/fxge/cfx_fontmapper.h
    core/fxge/cfx_fontmgr.cpp
    core/fxge/cfx_fontmgr.h
    core/fxge/cfx_gemodule.cpp
    core/fxge/cfx_gemodule.h
    core/fxge/cfx_graphstate.cpp
    core/fxge/cfx_graphstate.h
    core/fxge/cfx_graphstatedata.cpp
    core/fxge/cfx_graphstatedata.h
    core/fxge/cfx_pathdata.cpp
    core/fxge/cfx_pathdata.h
    core/fxge/cfx_renderdevice.cpp
    core/fxge/cfx_renderdevice.h
    core/fxge/cfx_substfont.cpp
    core/fxge/cfx_substfont.h
    core/fxge/cfx_unicodeencoding.cpp
    core/fxge/cfx_unicodeencoding.h
    core/fxge/cfx_windowsrenderdevice.h
    core/fxge/cttfontdesc.cpp
    core/fxge/cttfontdesc.h
    core/fxge/dib/cfx_bitmapcomposer.cpp
    core/fxge/dib/cfx_bitmapcomposer.h
    core/fxge/dib/cfx_bitmapstorer.cpp
    core/fxge/dib/cfx_bitmapstorer.h
    core/fxge/dib/cfx_dibextractor.cpp
    core/fxge/dib/cfx_dibextractor.h
    core/fxge/dib/cfx_dibitmap.cpp
    core/fxge/dib/cfx_dibitmap.h
    core/fxge/dib/cfx_dibsource.cpp
    core/fxge/dib/cfx_dibsource.h
    core/fxge/dib/cfx_filtereddib.cpp
    core/fxge/dib/cfx_filtereddib.h
    core/fxge/dib/cfx_imagerenderer.cpp
    core/fxge/dib/cfx_imagerenderer.h
    core/fxge/dib/cfx_imagestretcher.cpp
    core/fxge/dib/cfx_imagestretcher.h
    core/fxge/dib/cfx_imagetransformer.cpp
    core/fxge/dib/cfx_imagetransformer.h
    core/fxge/dib/cfx_scanlinecompositor.cpp
    core/fxge/dib/cfx_scanlinecompositor.h
    core/fxge/dib/cstretchengine.cpp
    core/fxge/dib/cstretchengine.h
    core/fxge/dib/fx_dib_main.cpp
    core/fxge/dib/ifx_scanlinecomposer.h
    core/fxge/fontdata/chromefontdata/FoxitDingbats.cpp
    core/fxge/fontdata/chromefontdata/FoxitFixed.cpp
    core/fxge/fontdata/chromefontdata/FoxitFixedBold.cpp
    core/fxge/fontdata/chromefontdata/FoxitFixedBoldItalic.cpp
    core/fxge/fontdata/chromefontdata/FoxitFixedItalic.cpp
    core/fxge/fontdata/chromefontdata/FoxitSans.cpp
    core/fxge/fontdata/chromefontdata/FoxitSansBold.cpp
    core/fxge/fontdata/chromefontdata/FoxitSansBoldItalic.cpp
    core/fxge/fontdata/chromefontdata/FoxitSansItalic.cpp
    core/fxge/fontdata/chromefontdata/FoxitSansMM.cpp
    core/fxge/fontdata/chromefontdata/FoxitSerif.cpp
    core/fxge/fontdata/chromefontdata/FoxitSerifBold.cpp
    core/fxge/fontdata/chromefontdata/FoxitSerifBoldItalic.cpp
    core/fxge/fontdata/chromefontdata/FoxitSerifItalic.cpp
    core/fxge/fontdata/chromefontdata/FoxitSerifMM.cpp
    core/fxge/fontdata/chromefontdata/FoxitSymbol.cpp
    core/fxge/fontdata/chromefontdata/chromefontdata.h
    core/fxge/freetype/fx_freetype.cpp
    core/fxge/fx_dib.h
    core/fxge/fx_font.h
    core/fxge/fx_freetype.h
    core/fxge/fx_ge_fontmap.cpp
    core/fxge/fx_ge_linux.cpp
    core/fxge/fx_ge_text.cpp
    core/fxge/ifx_renderdevicedriver.cpp
    core/fxge/ifx_renderdevicedriver.h
    core/fxge/ifx_systemfontinfo.h
    core/fxge/win32/cfx_windowsdib.h
    # TODO pdf_use_skia (skia vs. agg23)
    core/fxge/agg/fx_agg_driver.cpp
    core/fxge/agg/fx_agg_driver.h
    # TODO is_win
    # core/fxge/win32/dwrite_int.h
    # core/fxge/win32/fx_win32_device.cpp
    # core/fxge/win32/fx_win32_dib.cpp
    # core/fxge/win32/fx_win32_dwrite.cpp
    # core/fxge/win32/fx_win32_gdipext.cpp
    # core/fxge/win32/fx_win32_print.cpp
    # core/fxge/win32/win32_int.h
) # FXGE_SRC
if(APPLE)
    set(FXGE_SRC ${FXGE_SRC}
        core/fxge/apple/fx_apple_platform.cpp
        core/fxge/apple/apple_int.h
        core/fxge/apple/fx_mac_imp.cpp
        core/fxge/apple/fx_quartz_device.cpp
    ) # FXGE_SRC
endif()
set(PWL_SRC
    fpdfsdk/pwl/cpwl_appstream.cpp
    fpdfsdk/pwl/cpwl_appstream.h
    fpdfsdk/pwl/cpwl_button.cpp
    fpdfsdk/pwl/cpwl_button.h
    fpdfsdk/pwl/cpwl_caret.cpp
    fpdfsdk/pwl/cpwl_caret.h
    fpdfsdk/pwl/cpwl_combo_box.cpp
    fpdfsdk/pwl/cpwl_combo_box.h
    fpdfsdk/pwl/cpwl_edit.cpp
    fpdfsdk/pwl/cpwl_edit.h
    fpdfsdk/pwl/cpwl_edit_ctrl.cpp
    fpdfsdk/pwl/cpwl_edit_ctrl.h
    fpdfsdk/pwl/cpwl_edit_impl.cpp
    fpdfsdk/pwl/cpwl_edit_impl.h
    fpdfsdk/pwl/cpwl_font_map.cpp
    fpdfsdk/pwl/cpwl_font_map.h
    fpdfsdk/pwl/cpwl_icon.cpp
    fpdfsdk/pwl/cpwl_icon.h
    fpdfsdk/pwl/cpwl_list_box.cpp
    fpdfsdk/pwl/cpwl_list_box.h
    fpdfsdk/pwl/cpwl_list_impl.cpp
    fpdfsdk/pwl/cpwl_list_impl.h
    fpdfsdk/pwl/cpwl_scroll_bar.cpp
    fpdfsdk/pwl/cpwl_scroll_bar.h
    fpdfsdk/pwl/cpwl_special_button.cpp
    fpdfsdk/pwl/cpwl_special_button.h
    fpdfsdk/pwl/cpwl_timer.cpp
    fpdfsdk/pwl/cpwl_timer.h
    fpdfsdk/pwl/cpwl_timer_handler.cpp
    fpdfsdk/pwl/cpwl_timer_handler.h
    fpdfsdk/pwl/cpwl_wnd.cpp
    fpdfsdk/pwl/cpwl_wnd.h
) # PWL_SRC
if(ENABLE_V8)
    set(JAVASCRIPT_SRC
        fxjs/CJX_Define.h
        fxjs/JS_Define.cpp
        fxjs/JS_Define.h
        fxjs/cjs_annot.cpp
        fxjs/cjs_annot.h
        fxjs/cjs_app.cpp
        fxjs/cjs_app.h
        fxjs/cjs_border.cpp
        fxjs/cjs_border.h
        fxjs/cjs_color.cpp
        fxjs/cjs_color.h
        fxjs/cjs_console.cpp
        fxjs/cjs_console.h
        fxjs/cjs_delaydata.cpp
        fxjs/cjs_delaydata.h
        fxjs/cjs_display.cpp
        fxjs/cjs_display.h
        fxjs/cjs_document.cpp
        fxjs/cjs_document.h
        fxjs/cjs_embedobj.cpp
        fxjs/cjs_embedobj.h
        fxjs/cjs_event.cpp
        fxjs/cjs_event.h
        fxjs/cjs_event_context.cpp
        fxjs/cjs_event_context.h
        fxjs/cjs_eventhandler.cpp
        fxjs/cjs_eventhandler.h
        fxjs/cjs_field.cpp
        fxjs/cjs_field.h
        fxjs/cjs_font.cpp
        fxjs/cjs_font.h
        fxjs/cjs_global.cpp
        fxjs/cjs_global.h
        fxjs/cjs_globalarrays.cpp
        fxjs/cjs_globalarrays.h
        fxjs/cjs_globalconsts.cpp
        fxjs/cjs_globalconsts.h
        fxjs/cjs_globaldata.cpp
        fxjs/cjs_globaldata.h
        fxjs/cjs_globalvariablearray.cpp
        fxjs/cjs_globalvariablearray.h
        fxjs/cjs_highlight.cpp
        fxjs/cjs_highlight.h
        fxjs/cjs_icon.cpp
        fxjs/cjs_icon.h
        fxjs/cjs_keyvalue.cpp
        fxjs/cjs_keyvalue.h
        fxjs/cjs_object.cpp
        fxjs/cjs_object.h
        fxjs/cjs_position.cpp
        fxjs/cjs_position.h
        fxjs/cjs_printparamsobj.cpp
        fxjs/cjs_printparamsobj.h
        fxjs/cjs_publicmethods.cpp
        fxjs/cjs_publicmethods.h
        fxjs/cjs_report.cpp
        fxjs/cjs_report.h
        fxjs/cjs_return.cpp
        fxjs/cjs_return.h
        fxjs/cjs_runtime.cpp
        fxjs/cjs_runtime.h
        fxjs/cjs_scalehow.cpp
        fxjs/cjs_scalehow.h
        fxjs/cjs_scalewhen.cpp
        fxjs/cjs_scalewhen.h
        fxjs/cjs_style.cpp
        fxjs/cjs_style.h
        fxjs/cjs_timerobj.cpp
        fxjs/cjs_timerobj.h
        fxjs/cjs_util.cpp
        fxjs/cjs_util.h
        fxjs/cjs_v8.cpp
        fxjs/cjs_v8.h
        fxjs/cjs_zoomtype.cpp
        fxjs/cjs_zoomtype.h
        fxjs/fxjs_v8.cpp
        fxjs/fxjs_v8.h
        fxjs/global_timer.cpp
        fxjs/global_timer.h
        fxjs/js_resources.cpp
        fxjs/js_resources.h
    ) # JAVASCRIPT_SRC
else()
    set(JAVASCRIPT_SRC
        fxjs/cjs_event_context_stub.cpp
        fxjs/cjs_event_context_stub.h
        fxjs/cjs_runtimestub.cpp
    ) # JAVASCRIPT_SRC
endif()

set(FORMFILLER_SRC
    fpdfsdk/formfiller/cba_fontmap.cpp
    fpdfsdk/formfiller/cba_fontmap.h
    fpdfsdk/formfiller/cffl_button.cpp
    fpdfsdk/formfiller/cffl_button.h
    fpdfsdk/formfiller/cffl_checkbox.cpp
    fpdfsdk/formfiller/cffl_checkbox.h
    fpdfsdk/formfiller/cffl_combobox.cpp
    fpdfsdk/formfiller/cffl_combobox.h
    fpdfsdk/formfiller/cffl_formfiller.cpp
    fpdfsdk/formfiller/cffl_formfiller.h
    fpdfsdk/formfiller/cffl_interactiveformfiller.cpp
    fpdfsdk/formfiller/cffl_interactiveformfiller.h
    fpdfsdk/formfiller/cffl_listbox.cpp
    fpdfsdk/formfiller/cffl_listbox.h
    fpdfsdk/formfiller/cffl_pushbutton.cpp
    fpdfsdk/formfiller/cffl_pushbutton.h
    fpdfsdk/formfiller/cffl_radiobutton.cpp
    fpdfsdk/formfiller/cffl_radiobutton.h
    fpdfsdk/formfiller/cffl_textfield.cpp
    fpdfsdk/formfiller/cffl_textfield.h
    fpdfsdk/formfiller/cffl_textobject.cpp
    fpdfsdk/formfiller/cffl_textobject.h
) # FORMFILLER_SRC

set(THIRD_PARTY_BIGINT_SRC
    bigint/BigInteger.cc
    bigint/BigInteger.hh
    bigint/BigIntegerLibrary.hh
    bigint/BigIntegerUtils.cc
    bigint/BigIntegerUtils.hh
    bigint/BigUnsigned.cc
    bigint/BigUnsigned.hh
    bigint/BigUnsignedInABase.cc
    bigint/BigUnsignedInABase.hh
    bigint/NumberlikeArray.hh
) # THIRD_PARTY_BIGINT_SRC

set(THIRD_PARTY_FX_FREETYPE_SRC
    freetype/src/include/freetype/config/ftconfig.h
    freetype/src/include/freetype/config/ftheader.h
    freetype/src/include/freetype/config/ftstdlib.h
    freetype/src/include/freetype/freetype.h
    freetype/src/include/freetype/ftadvanc.h
    freetype/src/include/freetype/ftbitmap.h
    freetype/src/include/freetype/fterrdef.h
    freetype/src/include/freetype/fterrors.h
    freetype/src/include/freetype/ftglyph.h
    freetype/src/include/freetype/ftgzip.h
    freetype/src/include/freetype/ftimage.h
    freetype/src/include/freetype/ftincrem.h
    freetype/src/include/freetype/ftlcdfil.h
    freetype/src/include/freetype/ftlist.h
    freetype/src/include/freetype/ftmm.h
    freetype/src/include/freetype/ftmodapi.h
    freetype/src/include/freetype/ftmoderr.h
    freetype/src/include/freetype/ftotval.h
    freetype/src/include/freetype/ftoutln.h
    freetype/src/include/freetype/ftrender.h
    freetype/src/include/freetype/ftsizes.h
    freetype/src/include/freetype/ftsnames.h
    freetype/src/include/freetype/ftsystem.h
    freetype/src/include/freetype/fttrigon.h
    freetype/src/include/freetype/fttypes.h
    freetype/src/include/freetype/internal/autohint.h
    freetype/src/include/freetype/internal/cfftypes.h
    freetype/src/include/freetype/internal/ftcalc.h
    freetype/src/include/freetype/internal/ftdebug.h
    freetype/src/include/freetype/internal/ftdrv.h
    freetype/src/include/freetype/internal/ftgloadr.h
    freetype/src/include/freetype/internal/fthash.h
    freetype/src/include/freetype/internal/ftmemory.h
    freetype/src/include/freetype/internal/ftobjs.h
    freetype/src/include/freetype/internal/ftpic.h
    freetype/src/include/freetype/internal/ftrfork.h
    freetype/src/include/freetype/internal/ftserv.h
    freetype/src/include/freetype/internal/ftstream.h
    freetype/src/include/freetype/internal/ftvalid.h
    freetype/src/include/freetype/internal/internal.h
    freetype/src/include/freetype/internal/psaux.h
    freetype/src/include/freetype/internal/pshints.h
    freetype/src/include/freetype/internal/services/svcid.h
    freetype/src/include/freetype/internal/services/svfntfmt.h
    freetype/src/include/freetype/internal/services/svgldict.h
    freetype/src/include/freetype/internal/services/svkern.h
    freetype/src/include/freetype/internal/services/svmetric.h
    freetype/src/include/freetype/internal/services/svmm.h
    freetype/src/include/freetype/internal/services/svpostnm.h
    freetype/src/include/freetype/internal/services/svprop.h
    freetype/src/include/freetype/internal/services/svpscmap.h
    freetype/src/include/freetype/internal/services/svpsinfo.h
    freetype/src/include/freetype/internal/services/svsfnt.h
    freetype/src/include/freetype/internal/services/svttcmap.h
    freetype/src/include/freetype/internal/services/svtteng.h
    freetype/src/include/freetype/internal/services/svttglyf.h
    freetype/src/include/freetype/internal/sfnt.h
    freetype/src/include/freetype/internal/t1types.h
    freetype/src/include/freetype/internal/tttypes.h
    freetype/src/include/freetype/t1tables.h
    freetype/src/include/freetype/ttnameid.h
    freetype/src/include/freetype/tttables.h
    freetype/src/include/freetype/tttags.h
    freetype/src/include/ft2build.h
    freetype/src/src/base/ftbase.c
    freetype/src/src/base/ftbase.h
    freetype/src/src/base/ftbitmap.c
    freetype/src/src/base/ftfntfmt.c
    freetype/src/src/base/ftglyph.c
    freetype/src/src/base/ftinit.c
    freetype/src/src/base/ftlcdfil.c
    freetype/src/src/base/ftmm.c
    freetype/src/src/base/ftsystem.c
    freetype/src/src/cff/cff.c
    freetype/src/src/cff/cffobjs.h
    freetype/src/src/cid/type1cid.c
    freetype/src/src/psaux/psaux.c
    freetype/src/src/pshinter/pshinter.c
    freetype/src/src/psnames/psmodule.c
    freetype/src/src/raster/raster.c
    freetype/src/src/sfnt/sfnt.c
    freetype/src/src/smooth/smooth.c
    freetype/src/src/truetype/truetype.c
    freetype/src/src/type1/type1.c
    # config files:
    freetype/include/freetype-custom-config/ftmodule.h
    freetype/include/freetype-custom-config/ftoption.h
    # TODO pdf_use_skia
) #THIRD_PARTY_FX_FREETYPE_SRC

set(THIRD_PARTY_FX_AGG_SRC
    agg23/agg_basics.h
    agg23/agg_clip_liang_barsky.h
    agg23/agg_conv_dash.h
    agg23/agg_conv_stroke.h
    agg23/agg_curves.cpp
    agg23/agg_curves.h
    agg23/agg_path_storage.cpp
    agg23/agg_path_storage.h
    agg23/agg_rasterizer_scanline_aa.cpp
    agg23/agg_rasterizer_scanline_aa.h
    agg23/agg_renderer_scanline.h
    agg23/agg_rendering_buffer.h
    agg23/agg_scanline_u.h
    agg23/agg_vcgen_dash.cpp
    agg23/agg_vcgen_stroke.cpp
) # THIRD_PARTY_FX_AGG_SRC

set(THIRD_PARTY_FX_LCMS2
    lcms/include/lcms2.h
    lcms/include/lcms2_plugin.h
    lcms/src/cmsalpha.c
    lcms/src/cmscam02.c
    lcms/src/cmscgats.c
    lcms/src/cmscnvrt.c
    lcms/src/cmserr.c
    lcms/src/cmsgamma.c
    lcms/src/cmsgmt.c
    lcms/src/cmshalf.c
    lcms/src/cmsintrp.c
    lcms/src/cmsio0.c
    lcms/src/cmsio1.c
    lcms/src/cmslut.c
    lcms/src/cmsmd5.c
    lcms/src/cmsmtrx.c
    lcms/src/cmsnamed.c
    lcms/src/cmsopt.c
    lcms/src/cmspack.c
    lcms/src/cmspcs.c
    lcms/src/cmsplugin.c
    lcms/src/cmsps2.c
    lcms/src/cmssamp.c
    lcms/src/cmssm.c
    lcms/src/cmstypes.c
    lcms/src/cmsvirt.c
    lcms/src/cmswtpnt.c
    lcms/src/cmsxform.c
) # THIRD_PARTY_FX_LCMS2

set(THIRD_PARTY_FX_LIBOPENJPEG
    libopenjpeg20/bio.c
    libopenjpeg20/cio.c
    libopenjpeg20/dwt.c
    libopenjpeg20/event.c
    libopenjpeg20/function_list.c
    libopenjpeg20/image.c
    libopenjpeg20/invert.c
    libopenjpeg20/j2k.c
    libopenjpeg20/jp2.c
    libopenjpeg20/mct.c
    libopenjpeg20/mqc.c
    libopenjpeg20/openjpeg.c
    libopenjpeg20/opj_clock.c
    libopenjpeg20/pi.c
    libopenjpeg20/sparse_array.c
    libopenjpeg20/t1.c
    libopenjpeg20/t2.c
    libopenjpeg20/tcd.c
    libopenjpeg20/tgt.c
    libopenjpeg20/thread.c
) # THIRD_PARTY_FX_LIBOPENJPEG

set(THIRD_PARTY_PDFIUM_BASE_SRC
    base/allocator/partition_allocator/address_space_randomization.cc
    base/allocator/partition_allocator/address_space_randomization.h
    base/allocator/partition_allocator/oom.h
    base/allocator/partition_allocator/page_allocator.cc
    base/allocator/partition_allocator/page_allocator.h
    base/allocator/partition_allocator/partition_alloc.cc
    base/allocator/partition_allocator/partition_alloc.h
    base/allocator/partition_allocator/spin_lock.cc
    base/allocator/partition_allocator/spin_lock.h
    base/base_export.h
    base/bits.h
    base/compiler_specific.h
    base/logging.h
    base/macros.h
    base/numerics/safe_conversions.h
    base/numerics/safe_conversions_impl.h
    base/numerics/safe_math.h
    base/numerics/safe_math_impl.h
    base/optional.h
    base/ptr_util.h
    base/stl_util.h
    base/sys_byteorder.h
    base/template_util.h
    build/build_config.h
) # THIRD_PARTY_PDFIUM_BASE_SRC

set(THIRD_PARTY_SRC
    ${THIRD_PARTY_BIGINT_SRC}
    ${THIRD_PARTY_PDFIUM_BASE_SRC}
    ${THIRD_PARTY_FX_AGG_SRC}
    ${THIRD_PARTY_FX_LCMS2}
    ${THIRD_PARTY_FX_LIBOPENJPEG}
    ${THIRD_PARTY_JPEG}
) # THIRD_PARTY_SRC

set(MAIN_SRC
    ${PDFIUM_SRC}
    ${FDRM_SRC}
    ${FORMFILLER_SRC}
    ${FPDFAPI_SRC}
    ${FPDFDOC_SRC}
    ${FPDFTEXT_SRC}
    ${FXCODEC_SRC}
    ${FXCRT_SRC}
    ${FXGE_SRC}
    ${JAVASCRIPT_SRC}
    ${PWL_SRC}
) # MAIN_SRC

foreach(file IN LISTS MAIN_SRC)
    list(APPEND SRC pdfium/${file})
endforeach(file)

foreach(file IN LISTS THIRD_PARTY_SRC)
    list(APPEND SRC pdfium/third_party/${file})
endforeach(file)

foreach(file IN LISTS THIRD_PARTY_FX_FREETYPE_SRC)
    list(APPEND FREETYPE_SRC pdfium/third_party/${file})
endforeach(file)

# Freetype
add_library(freetype ${FREETYPE_SRC})
target_include_directories(freetype PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/pdfium/third_party/freetype/include>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/pdfium/third_party/freetype/src/include>
)
target_compile_definitions(freetype PRIVATE -DFT2_BUILD_LIBRARY -DFT_CONFIG_MODULES_H=<freetype-custom-config/ftmodule.h> -DFT_CONFIG_OPTIONS_H=<freetype-custom-config/ftoption.h>)

# PDFium
set(PDFIUM_DEFINES
    -DNOMINMAX
    -DOPJ_STATIC
    -DPNG_PREFIX
    -DPNG_USE_READ_MACROS
    -DV8_DEPRECATION_WARNINGS
    -DUSE_SYSTEM_LIBJPEG
    -DUSE_SYSTEM_ZLIB
    -DDEFINE_PS_TABLES
    -DDEFINE_PS_TABLES_DATA
)

if(ENABLE_V8)
    if(NOT V8_USE_SNAPSHOT)
        # V8_USE_EXTERNAL_SNAPSHOT without V8_USE_SNAPSHOT doesn't make sense
        SET(V8_USE_EXTERNAL_SNAPSHOT FALSE)
    endif()

    find_package(ICU REQUIRED COMPONENTS I18N UC REQUIRED)

    set(V8_SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/pdfium/v8)
    set(V8_OUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/v8)
    set(INSPECTOR_OUT_DIR ${V8_OUT_DIR}/src/inspector)

    file(MAKE_DIRECTORY ${V8_OUT_DIR})
    file(MAKE_DIRECTORY ${INSPECTOR_OUT_DIR})
    file(MAKE_DIRECTORY ${INSPECTOR_OUT_DIR}/../../include/inspector)

    set(COMMON_DEFINES
        -DV8_TARGET_ARCH_X64
        -DV8_INTL_SUPPORT
    )

    set(V8_MAIN_SRC
        src/v8dll-main.cc
    )

    # for all cases (mksnapshot / v8 no snapshot / internal / external)
    set(V8_BASE_SRC
        include/v8-debug.h
        include/v8-inspector-protocol.h
        include/v8-inspector.h
        include/v8-platform.h
        include/v8-profiler.h
        include/v8-testing.h
        include/v8-util.h
        include/v8.h
        include/v8config.h
        src/accessors.cc
        src/accessors.h
        src/address-map.cc
        src/address-map.h
        src/allocation-site-scopes.h
        src/allocation.cc
        src/allocation.h
        src/api-arguments-inl.h
        src/api-arguments.cc
        src/api-arguments.h
        src/api-natives.cc
        src/api-natives.h
        src/api.cc
        src/api.h
        src/arguments.cc
        src/arguments.h
        src/asmjs/asm-js.cc
        src/asmjs/asm-js.h
        src/asmjs/asm-names.h
        src/asmjs/asm-parser.cc
        src/asmjs/asm-parser.h
        src/asmjs/asm-scanner.cc
        src/asmjs/asm-scanner.h
        src/asmjs/asm-types.cc
        src/asmjs/asm-types.h
        src/asmjs/switch-logic.cc
        src/asmjs/switch-logic.h
        src/assembler-inl.h
        src/assembler.cc
        src/assembler.h
        src/assert-scope.cc
        src/assert-scope.h
        src/ast/ast-function-literal-id-reindexer.cc
        src/ast/ast-function-literal-id-reindexer.h
        src/ast/ast-source-ranges.h
        src/ast/ast-traversal-visitor.h
        src/ast/ast-value-factory.cc
        src/ast/ast-value-factory.h
        src/ast/ast.cc
        src/ast/ast.h
        src/ast/compile-time-value.cc
        src/ast/compile-time-value.h
        src/ast/context-slot-cache.cc
        src/ast/context-slot-cache.h
        src/ast/modules.cc
        src/ast/modules.h
        src/ast/prettyprinter.cc
        src/ast/prettyprinter.h
        src/ast/scopes.cc
        src/ast/scopes.h
        src/ast/variables.cc
        src/ast/variables.h
        src/bailout-reason.cc
        src/bailout-reason.h
        src/basic-block-profiler.cc
        src/basic-block-profiler.h
        src/bignum-dtoa.cc
        src/bignum-dtoa.h
        src/bignum.cc
        src/bignum.h
        src/bit-vector.cc
        src/bit-vector.h
        src/bootstrapper.cc
        src/bootstrapper.h
        src/boxed-float.h
        src/builtins/builtins-api.cc
        src/builtins/builtins-array.cc
        src/builtins/builtins-arraybuffer.cc
        src/builtins/builtins-bigint.cc
        src/builtins/builtins-boolean.cc
        src/builtins/builtins-call.cc
        src/builtins/builtins-callsite.cc
        src/builtins/builtins-collections.cc
        src/builtins/builtins-console.cc
        src/builtins/builtins-constructor.h
        src/builtins/builtins-dataview.cc
        src/builtins/builtins-date.cc
        src/builtins/builtins-definitions.h
        src/builtins/builtins-descriptors.h
        src/builtins/builtins-error.cc
        src/builtins/builtins-function.cc
        src/builtins/builtins-global.cc
        src/builtins/builtins-internal.cc
        src/builtins/builtins-interpreter.cc
        src/builtins/builtins-json.cc
        src/builtins/builtins-math.cc
        src/builtins/builtins-number.cc
        src/builtins/builtins-object.cc
        src/builtins/builtins-promise.cc
        src/builtins/builtins-reflect.cc
        src/builtins/builtins-regexp.cc
        src/builtins/builtins-sharedarraybuffer.cc
        src/builtins/builtins-string.cc
        src/builtins/builtins-symbol.cc
        src/builtins/builtins-typedarray.cc
        src/builtins/builtins-utils.h
        src/builtins/builtins.cc
        src/builtins/builtins.h
        src/cached-powers.cc
        src/cached-powers.h
        src/callable.h
        src/cancelable-task.cc
        src/cancelable-task.h
        src/char-predicates-inl.h
        src/char-predicates.h
        src/checks.h
        src/code-events.h
        src/code-factory.cc
        src/code-factory.h
        src/code-stub-assembler.cc
        src/code-stub-assembler.h
        src/code-stubs-utils.h
        src/code-stubs.cc
        src/code-stubs.h
        src/codegen.cc
        src/codegen.h
        src/collector.h
        src/compilation-cache.cc
        src/compilation-cache.h
        src/compilation-dependencies.cc
        src/compilation-dependencies.h
        src/compilation-info.cc
        src/compilation-info.h
        src/compilation-statistics.cc
        src/compilation-statistics.h
        src/compiler-dispatcher/compiler-dispatcher-job.cc
        src/compiler-dispatcher/compiler-dispatcher-job.h
        src/compiler-dispatcher/compiler-dispatcher-tracer.cc
        src/compiler-dispatcher/compiler-dispatcher-tracer.h
        src/compiler-dispatcher/compiler-dispatcher.cc
        src/compiler-dispatcher/compiler-dispatcher.h
        src/compiler-dispatcher/optimizing-compile-dispatcher.cc
        src/compiler-dispatcher/optimizing-compile-dispatcher.h
        src/compiler-dispatcher/unoptimized-compile-job.cc
        src/compiler-dispatcher/unoptimized-compile-job.h
        src/compiler.cc
        src/compiler.h
        src/compiler/access-builder.cc
        src/compiler/access-builder.h
        src/compiler/access-info.cc
        src/compiler/access-info.h
        src/compiler/all-nodes.cc
        src/compiler/all-nodes.h
        src/compiler/allocation-builder.h
        src/compiler/basic-block-instrumentor.cc
        src/compiler/basic-block-instrumentor.h
        src/compiler/branch-elimination.cc
        src/compiler/branch-elimination.h
        src/compiler/bytecode-analysis.cc
        src/compiler/bytecode-analysis.h
        src/compiler/bytecode-graph-builder.cc
        src/compiler/bytecode-graph-builder.h
        src/compiler/bytecode-liveness-map.cc
        src/compiler/bytecode-liveness-map.h
        src/compiler/c-linkage.cc
        src/compiler/checkpoint-elimination.cc
        src/compiler/checkpoint-elimination.h
        src/compiler/code-assembler.cc
        src/compiler/code-assembler.h
        src/compiler/code-generator-impl.h
        src/compiler/code-generator.cc
        src/compiler/code-generator.h
        src/compiler/common-node-cache.cc
        src/compiler/common-node-cache.h
        src/compiler/common-operator-reducer.cc
        src/compiler/common-operator-reducer.h
        src/compiler/common-operator.cc
        src/compiler/common-operator.h
        src/compiler/compiler-source-position-table.cc
        src/compiler/compiler-source-position-table.h
        src/compiler/control-equivalence.cc
        src/compiler/control-equivalence.h
        src/compiler/control-flow-optimizer.cc
        src/compiler/control-flow-optimizer.h
        src/compiler/dead-code-elimination.cc
        src/compiler/dead-code-elimination.h
        src/compiler/diamond.h
        src/compiler/effect-control-linearizer.cc
        src/compiler/effect-control-linearizer.h
        src/compiler/escape-analysis-reducer.cc
        src/compiler/escape-analysis-reducer.h
        src/compiler/escape-analysis.cc
        src/compiler/escape-analysis.h
        src/compiler/frame-elider.cc
        src/compiler/frame-elider.h
        src/compiler/frame-states.cc
        src/compiler/frame-states.h
        src/compiler/frame.cc
        src/compiler/frame.h
        src/compiler/gap-resolver.cc
        src/compiler/gap-resolver.h
        src/compiler/graph-assembler.cc
        src/compiler/graph-assembler.h
        src/compiler/graph-reducer.cc
        src/compiler/graph-reducer.h
        src/compiler/graph-trimmer.cc
        src/compiler/graph-trimmer.h
        src/compiler/graph-visualizer.cc
        src/compiler/graph-visualizer.h
        src/compiler/graph.cc
        src/compiler/graph.h
        src/compiler/instruction-codes.h
        src/compiler/instruction-scheduler.cc
        src/compiler/instruction-scheduler.h
        src/compiler/instruction-selector-impl.h
        src/compiler/instruction-selector.cc
        src/compiler/instruction-selector.h
        src/compiler/instruction.cc
        src/compiler/instruction.h
        src/compiler/int64-lowering.cc
        src/compiler/int64-lowering.h
        src/compiler/js-builtin-reducer.cc
        src/compiler/js-builtin-reducer.h
        src/compiler/js-call-reducer.cc
        src/compiler/js-call-reducer.h
        src/compiler/js-context-specialization.cc
        src/compiler/js-context-specialization.h
        src/compiler/js-create-lowering.cc
        src/compiler/js-create-lowering.h
        src/compiler/js-generic-lowering.cc
        src/compiler/js-generic-lowering.h
        src/compiler/js-graph.cc
        src/compiler/js-graph.h
        src/compiler/js-inlining-heuristic.cc
        src/compiler/js-inlining-heuristic.h
        src/compiler/js-inlining.cc
        src/compiler/js-inlining.h
        src/compiler/js-intrinsic-lowering.cc
        src/compiler/js-intrinsic-lowering.h
        src/compiler/js-native-context-specialization.cc
        src/compiler/js-native-context-specialization.h
        src/compiler/js-operator.cc
        src/compiler/js-operator.h
        src/compiler/js-type-hint-lowering.cc
        src/compiler/js-type-hint-lowering.h
        src/compiler/js-typed-lowering.cc
        src/compiler/js-typed-lowering.h
        src/compiler/jump-threading.cc
        src/compiler/jump-threading.h
        src/compiler/linkage.cc
        src/compiler/linkage.h
        src/compiler/live-range-separator.cc
        src/compiler/live-range-separator.h
        src/compiler/load-elimination.cc
        src/compiler/load-elimination.h
        src/compiler/loop-analysis.cc
        src/compiler/loop-analysis.h
        src/compiler/loop-peeling.cc
        src/compiler/loop-peeling.h
        src/compiler/loop-variable-optimizer.cc
        src/compiler/loop-variable-optimizer.h
        src/compiler/machine-graph-verifier.cc
        src/compiler/machine-graph-verifier.h
        src/compiler/machine-operator-reducer.cc
        src/compiler/machine-operator-reducer.h
        src/compiler/machine-operator.cc
        src/compiler/machine-operator.h
        src/compiler/memory-optimizer.cc
        src/compiler/memory-optimizer.h
        src/compiler/move-optimizer.cc
        src/compiler/move-optimizer.h
        src/compiler/node-aux-data.h
        src/compiler/node-cache.cc
        src/compiler/node-cache.h
        src/compiler/node-marker.cc
        src/compiler/node-marker.h
        src/compiler/node-matchers.cc
        src/compiler/node-matchers.h
        src/compiler/node-properties.cc
        src/compiler/node-properties.h
        src/compiler/node.cc
        src/compiler/node.h
        src/compiler/opcodes.cc
        src/compiler/opcodes.h
        src/compiler/operation-typer.cc
        src/compiler/operation-typer.h
        src/compiler/operator-properties.cc
        src/compiler/operator-properties.h
        src/compiler/operator.cc
        src/compiler/operator.h
        src/compiler/osr.cc
        src/compiler/osr.h
        src/compiler/persistent-map.h
        src/compiler/pipeline-statistics.cc
        src/compiler/pipeline-statistics.h
        src/compiler/pipeline.cc
        src/compiler/pipeline.h
        src/compiler/property-access-builder.cc
        src/compiler/property-access-builder.h
        src/compiler/raw-machine-assembler.cc
        src/compiler/raw-machine-assembler.h
        src/compiler/redundancy-elimination.cc
        src/compiler/redundancy-elimination.h
        src/compiler/register-allocator-verifier.cc
        src/compiler/register-allocator-verifier.h
        src/compiler/register-allocator.cc
        src/compiler/register-allocator.h
        src/compiler/representation-change.cc
        src/compiler/representation-change.h
        src/compiler/schedule.cc
        src/compiler/schedule.h
        src/compiler/scheduler.cc
        src/compiler/scheduler.h
        src/compiler/select-lowering.cc
        src/compiler/select-lowering.h
        src/compiler/simd-scalar-lowering.cc
        src/compiler/simd-scalar-lowering.h
        src/compiler/simplified-lowering.cc
        src/compiler/simplified-lowering.h
        src/compiler/simplified-operator-reducer.cc
        src/compiler/simplified-operator-reducer.h
        src/compiler/simplified-operator.cc
        src/compiler/simplified-operator.h
        src/compiler/state-values-utils.cc
        src/compiler/state-values-utils.h
        src/compiler/store-store-elimination.cc
        src/compiler/store-store-elimination.h
        src/compiler/type-cache.cc
        src/compiler/type-cache.h
        src/compiler/typed-optimization.cc
        src/compiler/typed-optimization.h
        src/compiler/typer.cc
        src/compiler/typer.h
        src/compiler/types.cc
        src/compiler/types.h
        src/compiler/unwinding-info-writer.h
        src/compiler/value-numbering-reducer.cc
        src/compiler/value-numbering-reducer.h
        src/compiler/verifier.cc
        src/compiler/verifier.h
        src/compiler/wasm-compiler.cc
        src/compiler/wasm-compiler.h
        src/compiler/wasm-linkage.cc
        src/compiler/zone-stats.cc
        src/compiler/zone-stats.h
        src/contexts-inl.h
        src/contexts.cc
        src/contexts.h
        src/conversions-inl.h
        src/conversions.cc
        src/conversions.h
        src/counters-inl.h
        src/counters.cc
        src/counters.h
        src/date.cc
        src/date.h
        src/dateparser-inl.h
        src/dateparser.cc
        src/dateparser.h
        src/debug/debug-coverage.cc
        src/debug/debug-coverage.h
        src/debug/debug-evaluate.cc
        src/debug/debug-evaluate.h
        src/debug/debug-frames.cc
        src/debug/debug-frames.h
        src/debug/debug-interface.h
        src/debug/debug-scope-iterator.cc
        src/debug/debug-scope-iterator.h
        src/debug/debug-scopes.cc
        src/debug/debug-scopes.h
        src/debug/debug-stack-trace-iterator.cc
        src/debug/debug-stack-trace-iterator.h
        src/debug/debug-type-profile.cc
        src/debug/debug-type-profile.h
        src/debug/debug.cc
        src/debug/debug.h
        src/debug/interface-types.h
        src/debug/liveedit.cc
        src/debug/liveedit.h
        src/deoptimize-reason.cc
        src/deoptimize-reason.h
        src/deoptimizer.cc
        src/deoptimizer.h
        src/detachable-vector.h
        src/disasm.h
        src/disassembler.cc
        src/disassembler.h
        src/diy-fp.cc
        src/diy-fp.h
        src/double.h
        src/dtoa.cc
        src/dtoa.h
        src/eh-frame.cc
        src/eh-frame.h
        src/elements-kind.cc
        src/elements-kind.h
        src/elements.cc
        src/elements.h
        src/execution.cc
        src/execution.h
        src/extensions/externalize-string-extension.cc
        src/extensions/externalize-string-extension.h
        src/extensions/free-buffer-extension.cc
        src/extensions/free-buffer-extension.h
        src/extensions/gc-extension.cc
        src/extensions/gc-extension.h
        src/extensions/ignition-statistics-extension.cc
        src/extensions/ignition-statistics-extension.h
        src/extensions/statistics-extension.cc
        src/extensions/statistics-extension.h
        src/extensions/trigger-failure-extension.cc
        src/extensions/trigger-failure-extension.h
        src/external-reference-table.cc
        src/external-reference-table.h
        src/factory-inl.h
        src/factory.cc
        src/factory.h
        src/fast-dtoa.cc
        src/fast-dtoa.h
        src/feedback-vector-inl.h
        src/feedback-vector.cc
        src/feedback-vector.h
        src/field-index-inl.h
        src/field-index.h
        src/field-type.cc
        src/field-type.h
        src/fixed-dtoa.cc
        src/fixed-dtoa.h
        src/flag-definitions.h
        src/flags.cc
        src/flags.h
        src/frame-constants.h
        src/frames-inl.h
        src/frames.cc
        src/frames.h
        src/futex-emulation.cc
        src/futex-emulation.h
        src/gdb-jit.cc
        src/gdb-jit.h
        src/global-handles.cc
        src/global-handles.h
        src/globals.h
        src/handles-inl.h
        src/handles.cc
        src/handles.h
        src/heap-symbols.h
        src/heap/array-buffer-collector.cc
        src/heap/array-buffer-collector.h
        src/heap/array-buffer-tracker-inl.h
        src/heap/array-buffer-tracker.cc
        src/heap/array-buffer-tracker.h
        src/heap/barrier.h
        src/heap/code-stats.cc
        src/heap/code-stats.h
        src/heap/concurrent-marking.cc
        src/heap/concurrent-marking.h
        src/heap/embedder-tracing.cc
        src/heap/embedder-tracing.h
        src/heap/gc-idle-time-handler.cc
        src/heap/gc-idle-time-handler.h
        src/heap/gc-tracer.cc
        src/heap/gc-tracer.h
        src/heap/heap-inl.h
        src/heap/heap.cc
        src/heap/heap.h
        src/heap/incremental-marking-inl.h
        src/heap/incremental-marking-job.cc
        src/heap/incremental-marking-job.h
        src/heap/incremental-marking.cc
        src/heap/incremental-marking.h
        src/heap/invalidated-slots-inl.h
        src/heap/invalidated-slots.cc
        src/heap/invalidated-slots.h
        src/heap/item-parallel-job.h
        src/heap/local-allocator.h
        src/heap/mark-compact-inl.h
        src/heap/mark-compact.cc
        src/heap/mark-compact.h
        src/heap/marking.cc
        src/heap/marking.h
        src/heap/memory-reducer.cc
        src/heap/memory-reducer.h
        src/heap/object-stats.cc
        src/heap/object-stats.h
        src/heap/objects-visiting-inl.h
        src/heap/objects-visiting.cc
        src/heap/objects-visiting.h
        src/heap/remembered-set.h
        src/heap/scavenge-job.cc
        src/heap/scavenge-job.h
        src/heap/scavenger-inl.h
        src/heap/scavenger.cc
        src/heap/scavenger.h
        src/heap/slot-set.h
        src/heap/spaces-inl.h
        src/heap/spaces.cc
        src/heap/spaces.h
        src/heap/store-buffer.cc
        src/heap/store-buffer.h
        src/heap/stress-marking-observer.cc
        src/heap/stress-marking-observer.h
        src/heap/stress-scavenge-observer.cc
        src/heap/stress-scavenge-observer.h
        src/heap/sweeper.cc
        src/heap/sweeper.h
        src/heap/worklist.h
        src/ic/call-optimization.cc
        src/ic/call-optimization.h
        src/ic/handler-configuration-inl.h
        src/ic/handler-configuration.cc
        src/ic/handler-configuration.h
        src/ic/ic-inl.h
        src/ic/ic-stats.cc
        src/ic/ic-stats.h
        src/ic/ic.cc
        src/ic/ic.h
        src/ic/stub-cache.cc
        src/ic/stub-cache.h
        src/icu_util.cc
        src/icu_util.h
        src/identity-map.cc
        src/identity-map.h
        src/interface-descriptors.cc
        src/interface-descriptors.h
        src/interpreter/block-coverage-builder.h
        src/interpreter/bytecode-array-accessor.cc
        src/interpreter/bytecode-array-accessor.h
        src/interpreter/bytecode-array-builder.cc
        src/interpreter/bytecode-array-builder.h
        src/interpreter/bytecode-array-iterator.cc
        src/interpreter/bytecode-array-iterator.h
        src/interpreter/bytecode-array-random-iterator.cc
        src/interpreter/bytecode-array-random-iterator.h
        src/interpreter/bytecode-array-writer.cc
        src/interpreter/bytecode-array-writer.h
        src/interpreter/bytecode-decoder.cc
        src/interpreter/bytecode-decoder.h
        src/interpreter/bytecode-flags.cc
        src/interpreter/bytecode-flags.h
        src/interpreter/bytecode-generator.cc
        src/interpreter/bytecode-generator.h
        src/interpreter/bytecode-jump-table.h
        src/interpreter/bytecode-label.cc
        src/interpreter/bytecode-label.h
        src/interpreter/bytecode-node.cc
        src/interpreter/bytecode-node.h
        src/interpreter/bytecode-operands.cc
        src/interpreter/bytecode-operands.h
        src/interpreter/bytecode-register-allocator.h
        src/interpreter/bytecode-register-optimizer.cc
        src/interpreter/bytecode-register-optimizer.h
        src/interpreter/bytecode-register.cc
        src/interpreter/bytecode-register.h
        src/interpreter/bytecode-source-info.cc
        src/interpreter/bytecode-source-info.h
        src/interpreter/bytecode-traits.h
        src/interpreter/bytecodes.cc
        src/interpreter/bytecodes.h
        src/interpreter/constant-array-builder.cc
        src/interpreter/constant-array-builder.h
        src/interpreter/control-flow-builders.cc
        src/interpreter/control-flow-builders.h
        src/interpreter/handler-table-builder.cc
        src/interpreter/handler-table-builder.h
        src/interpreter/interpreter-generator.h
        src/interpreter/interpreter-intrinsics.cc
        src/interpreter/interpreter-intrinsics.h
        src/interpreter/interpreter.cc
        src/interpreter/interpreter.h
        src/isolate-inl.h
        src/isolate.cc
        src/isolate.h
        src/json-parser.cc
        src/json-parser.h
        src/json-stringifier.cc
        src/json-stringifier.h
        src/keys.cc
        src/keys.h
        src/label.h
        src/layout-descriptor-inl.h
        src/layout-descriptor.cc
        src/layout-descriptor.h
        src/locked-queue-inl.h
        src/locked-queue.h
        src/log-inl.h
        src/log-utils.cc
        src/log-utils.h
        src/log.cc
        src/log.h
        src/lookup-cache-inl.h
        src/lookup-cache.cc
        src/lookup-cache.h
        src/lookup.cc
        src/lookup.h
        src/machine-type.cc
        src/machine-type.h
        src/macro-assembler-inl.h
        src/macro-assembler.h
        src/managed.h
        src/map-updater.cc
        src/map-updater.h
        src/messages.cc
        src/messages.h
        src/msan.h
        src/objects-body-descriptors-inl.h
        src/objects-body-descriptors.h
        src/objects-debug.cc
        src/objects-inl.h
        src/objects-printer.cc
        src/objects.cc
        src/objects.h
        src/objects/arguments-inl.h
        src/objects/arguments.h
        src/objects/bigint.cc
        src/objects/bigint.h
        src/objects/code-inl.h
        src/objects/code.h
        src/objects/compilation-cache-inl.h
        src/objects/compilation-cache.h
        src/objects/debug-objects-inl.h
        src/objects/debug-objects.cc
        src/objects/debug-objects.h
        src/objects/descriptor-array.h
        src/objects/dictionary.h
        src/objects/fixed-array-inl.h
        src/objects/fixed-array.h
        src/objects/frame-array-inl.h
        src/objects/frame-array.h
        src/objects/hash-table-inl.h
        src/objects/hash-table.h
        src/objects/js-array-inl.h
        src/objects/js-array.h
        src/objects/js-collection-inl.h
        src/objects/js-collection.h
        src/objects/js-regexp-inl.h
        src/objects/js-regexp.h
        src/objects/literal-objects-inl.h
        src/objects/literal-objects.cc
        src/objects/literal-objects.h
        src/objects/map-inl.h
        src/objects/map.h
        src/objects/module-inl.h
        src/objects/module.cc
        src/objects/module.h
        src/objects/name-inl.h
        src/objects/name.h
        src/objects/object-macros-undef.h
        src/objects/object-macros.h
        src/objects/property-descriptor-object-inl.h
        src/objects/property-descriptor-object.h
        src/objects/regexp-match-info.h
        src/objects/scope-info.cc
        src/objects/scope-info.h
        src/objects/script-inl.h
        src/objects/script.h
        src/objects/shared-function-info-inl.h
        src/objects/shared-function-info.h
        src/objects/string-inl.h
        src/objects/string-table.h
        src/objects/string.h
        src/objects/template-objects.cc
        src/objects/template-objects.h
        src/ostreams.cc
        src/ostreams.h
        src/parsing/background-parsing-task.cc
        src/parsing/background-parsing-task.h
        src/parsing/duplicate-finder.h
        src/parsing/expression-classifier.h
        src/parsing/expression-scope-reparenter.cc
        src/parsing/expression-scope-reparenter.h
        src/parsing/func-name-inferrer.cc
        src/parsing/func-name-inferrer.h
        src/parsing/parse-info.cc
        src/parsing/parse-info.h
        src/parsing/parser-base.h
        src/parsing/parser.cc
        src/parsing/parser.h
        src/parsing/parsing.cc
        src/parsing/parsing.h
        src/parsing/pattern-rewriter.cc
        src/parsing/preparse-data-format.h
        src/parsing/preparse-data.cc
        src/parsing/preparse-data.h
        src/parsing/preparsed-scope-data.cc
        src/parsing/preparsed-scope-data.h
        src/parsing/preparser.cc
        src/parsing/preparser.h
        src/parsing/rewriter.cc
        src/parsing/rewriter.h
        src/parsing/scanner-character-streams.cc
        src/parsing/scanner-character-streams.h
        src/parsing/scanner.cc
        src/parsing/scanner.h
        src/parsing/token.cc
        src/parsing/token.h
        src/pending-compilation-error-handler.cc
        src/pending-compilation-error-handler.h
        src/perf-jit.cc
        src/perf-jit.h
        src/profiler/allocation-tracker.cc
        src/profiler/allocation-tracker.h
        src/profiler/circular-queue-inl.h
        src/profiler/circular-queue.h
        src/profiler/cpu-profiler-inl.h
        src/profiler/cpu-profiler.cc
        src/profiler/cpu-profiler.h
        src/profiler/heap-profiler.cc
        src/profiler/heap-profiler.h
        src/profiler/heap-snapshot-generator-inl.h
        src/profiler/heap-snapshot-generator.cc
        src/profiler/heap-snapshot-generator.h
        src/profiler/profile-generator-inl.h
        src/profiler/profile-generator.cc
        src/profiler/profile-generator.h
        src/profiler/profiler-listener.cc
        src/profiler/profiler-listener.h
        src/profiler/sampling-heap-profiler.cc
        src/profiler/sampling-heap-profiler.h
        src/profiler/strings-storage.cc
        src/profiler/strings-storage.h
        src/profiler/tick-sample.cc
        src/profiler/tick-sample.h
        src/profiler/tracing-cpu-profiler.cc
        src/profiler/tracing-cpu-profiler.h
        src/profiler/unbound-queue-inl.h
        src/profiler/unbound-queue.h
        src/property-descriptor.cc
        src/property-descriptor.h
        src/property-details.h
        src/property.cc
        src/property.h
        src/prototype.h
        src/regexp/bytecodes-irregexp.h
        src/regexp/interpreter-irregexp.cc
        src/regexp/interpreter-irregexp.h
        src/regexp/jsregexp-inl.h
        src/regexp/jsregexp.cc
        src/regexp/jsregexp.h
        src/regexp/regexp-ast.cc
        src/regexp/regexp-ast.h
        src/regexp/regexp-macro-assembler-irregexp-inl.h
        src/regexp/regexp-macro-assembler-irregexp.cc
        src/regexp/regexp-macro-assembler-irregexp.h
        src/regexp/regexp-macro-assembler-tracer.cc
        src/regexp/regexp-macro-assembler-tracer.h
        src/regexp/regexp-macro-assembler.cc
        src/regexp/regexp-macro-assembler.h
        src/regexp/regexp-parser.cc
        src/regexp/regexp-parser.h
        src/regexp/regexp-stack.cc
        src/regexp/regexp-stack.h
        src/regexp/regexp-utils.cc
        src/regexp/regexp-utils.h
        src/register-configuration.cc
        src/register-configuration.h
        src/reglist.h
        src/runtime-profiler.cc
        src/runtime-profiler.h
        src/runtime/runtime-array.cc
        src/runtime/runtime-atomics.cc
        src/runtime/runtime-bigint.cc
        src/runtime/runtime-classes.cc
        src/runtime/runtime-collections.cc
        src/runtime/runtime-compiler.cc
        src/runtime/runtime-date.cc
        src/runtime/runtime-debug.cc
        src/runtime/runtime-error.cc
        src/runtime/runtime-forin.cc
        src/runtime/runtime-function.cc
        src/runtime/runtime-futex.cc
        src/runtime/runtime-generator.cc
        src/runtime/runtime-internal.cc
        src/runtime/runtime-interpreter.cc
        src/runtime/runtime-literals.cc
        src/runtime/runtime-liveedit.cc
        src/runtime/runtime-maths.cc
        src/runtime/runtime-module.cc
        src/runtime/runtime-numbers.cc
        src/runtime/runtime-object.cc
        src/runtime/runtime-operators.cc
        src/runtime/runtime-promise.cc
        src/runtime/runtime-proxy.cc
        src/runtime/runtime-regexp.cc
        src/runtime/runtime-scopes.cc
        src/runtime/runtime-strings.cc
        src/runtime/runtime-symbol.cc
        src/runtime/runtime-test.cc
        src/runtime/runtime-typedarray.cc
        src/runtime/runtime-utils.h
        src/runtime/runtime-wasm.cc
        src/runtime/runtime.cc
        src/runtime/runtime.h
        src/safepoint-table.cc
        src/safepoint-table.h
        src/setup-isolate.h
        src/signature.h
        src/simulator-base.cc
        src/simulator-base.h
        src/simulator.h
        src/snapshot/builtin-deserializer-allocator.cc
        src/snapshot/builtin-deserializer-allocator.h
        src/snapshot/builtin-deserializer.cc
        src/snapshot/builtin-deserializer.h
        src/snapshot/builtin-serializer-allocator.cc
        src/snapshot/builtin-serializer-allocator.h
        src/snapshot/builtin-serializer.cc
        src/snapshot/builtin-serializer.h
        src/snapshot/builtin-snapshot-utils.cc
        src/snapshot/builtin-snapshot-utils.h
        src/snapshot/code-serializer.cc
        src/snapshot/code-serializer.h
        src/snapshot/default-deserializer-allocator.cc
        src/snapshot/default-deserializer-allocator.h
        src/snapshot/default-serializer-allocator.cc
        src/snapshot/default-serializer-allocator.h
        src/snapshot/deserializer.cc
        src/snapshot/deserializer.h
        src/snapshot/natives-common.cc
        src/snapshot/natives.h
        src/snapshot/object-deserializer.cc
        src/snapshot/object-deserializer.h
        src/snapshot/partial-deserializer.cc
        src/snapshot/partial-deserializer.h
        src/snapshot/partial-serializer.cc
        src/snapshot/partial-serializer.h
        src/snapshot/serializer-common.cc
        src/snapshot/serializer-common.h
        src/snapshot/serializer.cc
        src/snapshot/serializer.h
        src/snapshot/snapshot-common.cc
        src/snapshot/snapshot-source-sink.cc
        src/snapshot/snapshot-source-sink.h
        src/snapshot/snapshot.h
        src/snapshot/startup-deserializer.cc
        src/snapshot/startup-deserializer.h
        src/snapshot/startup-serializer.cc
        src/snapshot/startup-serializer.h
        src/source-position-table.cc
        src/source-position-table.h
        src/source-position.cc
        src/source-position.h
        src/splay-tree-inl.h
        src/splay-tree.h
        src/startup-data-util.cc
        src/startup-data-util.h
        src/string-builder.cc
        src/string-builder.h
        src/string-case.cc
        src/string-case.h
        src/string-hasher-inl.h
        src/string-hasher.h
        src/string-search.h
        src/string-stream.cc
        src/string-stream.h
        src/strtod.cc
        src/strtod.h
        src/third_party/utf8-decoder/utf8-decoder.h
        src/tracing/trace-event.cc
        src/tracing/trace-event.h
        src/tracing/traced-value.cc
        src/tracing/traced-value.h
        src/tracing/tracing-category-observer.cc
        src/tracing/tracing-category-observer.h
        src/transitions-inl.h
        src/transitions.cc
        src/transitions.h
        src/trap-handler/handler-outside.cc
        src/trap-handler/handler-shared.cc
        src/trap-handler/trap-handler-internal.h
        src/trap-handler/trap-handler.h
        src/type-hints.cc
        src/type-hints.h
        src/unicode-cache-inl.h
        src/unicode-cache.h
        src/unicode-decoder.cc
        src/unicode-decoder.h
        src/unicode-inl.h
        src/unicode.cc
        src/unicode.h
        src/uri.cc
        src/uri.h
        src/utils-inl.h
        src/utils.cc
        src/utils.h
        src/v8.cc
        src/v8.h
        src/v8memory.h
        src/v8threads.cc
        src/v8threads.h
        src/value-serializer.cc
        src/value-serializer.h
        src/vector-slot-pair.cc
        src/vector-slot-pair.h
        src/vector.h
        src/version.cc
        src/version.h
        src/visitors.cc
        src/visitors.h
        src/vm-state-inl.h
        src/vm-state.h
        src/wasm/baseline/liftoff-assembler-defs.h
        src/wasm/baseline/liftoff-assembler.cc
        src/wasm/baseline/liftoff-assembler.h
        src/wasm/baseline/liftoff-compiler.cc
        src/wasm/baseline/liftoff-register.h
        src/wasm/compilation-manager.cc
        src/wasm/compilation-manager.h
        src/wasm/decoder.h
        src/wasm/function-body-decoder-impl.h
        src/wasm/function-body-decoder.cc
        src/wasm/function-body-decoder.h
        src/wasm/leb-helper.h
        src/wasm/local-decl-encoder.cc
        src/wasm/local-decl-encoder.h
        src/wasm/memory-tracing.cc
        src/wasm/memory-tracing.h
        src/wasm/module-compiler.cc
        src/wasm/module-compiler.h
        src/wasm/module-decoder.cc
        src/wasm/module-decoder.h
        src/wasm/signature-map.cc
        src/wasm/signature-map.h
        src/wasm/streaming-decoder.cc
        src/wasm/streaming-decoder.h
        src/wasm/wasm-api.cc
        src/wasm/wasm-api.h
        src/wasm/wasm-code-manager.cc
        src/wasm/wasm-code-manager.h
        src/wasm/wasm-code-specialization.cc
        src/wasm/wasm-code-specialization.h
        src/wasm/wasm-code-wrapper.cc
        src/wasm/wasm-code-wrapper.h
        src/wasm/wasm-constants.h
        src/wasm/wasm-debug.cc
        src/wasm/wasm-engine.cc
        src/wasm/wasm-engine.h
        src/wasm/wasm-external-refs.cc
        src/wasm/wasm-external-refs.h
        src/wasm/wasm-interpreter.cc
        src/wasm/wasm-interpreter.h
        src/wasm/wasm-js.cc
        src/wasm/wasm-js.h
        src/wasm/wasm-limits.h
        src/wasm/wasm-memory.cc
        src/wasm/wasm-memory.h
        src/wasm/wasm-module-builder.cc
        src/wasm/wasm-module-builder.h
        src/wasm/wasm-module.cc
        src/wasm/wasm-module.h
        src/wasm/wasm-objects-inl.h
        src/wasm/wasm-objects.cc
        src/wasm/wasm-objects.h
        src/wasm/wasm-opcodes.cc
        src/wasm/wasm-opcodes.h
        src/wasm/wasm-result.cc
        src/wasm/wasm-result.h
        src/wasm/wasm-serialization.cc
        src/wasm/wasm-serialization.h
        src/wasm/wasm-text.cc
        src/wasm/wasm-text.h
        src/wasm/wasm-value.h
        src/zone/accounting-allocator.cc
        src/zone/accounting-allocator.h
        src/zone/zone-allocator.h
        src/zone/zone-allocator.h
        src/zone/zone-chunk-list.h
        src/zone/zone-containers.h
        src/zone/zone-handle-set.h
        src/zone/zone-list-inl.h
        src/zone/zone-segment.cc
        src/zone/zone-segment.h
        src/zone/zone.cc
        src/zone/zone.h
        # x64 files:
        src/compiler/x64/code-generator-x64.cc
        src/compiler/x64/instruction-codes-x64.h
        src/compiler/x64/instruction-scheduler-x64.cc
        src/compiler/x64/instruction-selector-x64.cc
        src/compiler/x64/unwinding-info-writer-x64.cc
        src/compiler/x64/unwinding-info-writer-x64.h
        src/debug/x64/debug-x64.cc
        src/regexp/x64/regexp-macro-assembler-x64.cc
        src/regexp/x64/regexp-macro-assembler-x64.h
        src/third_party/valgrind/valgrind.h
        src/wasm/baseline/x64/liftoff-assembler-x64.h
        src/x64/assembler-x64-inl.h
        src/x64/assembler-x64.cc
        src/x64/assembler-x64.h
        src/x64/code-stubs-x64.cc
        src/x64/codegen-x64.cc
        src/x64/cpu-x64.cc
        src/x64/deoptimizer-x64.cc
        src/x64/disasm-x64.cc
        src/x64/eh-frame-x64.cc
        src/x64/frame-constants-x64.cc
        src/x64/frame-constants-x64.h
        src/x64/interface-descriptors-x64.cc
        src/x64/macro-assembler-x64.cc
        src/x64/macro-assembler-x64.h
        src/x64/simulator-x64.cc
        src/x64/simulator-x64.h
        src/x64/sse-instr.h
        # i18n:
        src/builtins/builtins-intl.cc
        src/builtins/builtins-intl.h
        src/char-predicates.cc
        src/intl.cc
        src/intl.h
        src/objects/intl-objects.cc
        src/objects/intl-objects.h
        src/runtime/runtime-intl.cc

        # TODO deps for Win: //third_party/icu:icudata
    ) # V8_BASE_SRC

    if(LINUX)
        list(APPEND V8_BASE_SRC
            src/trap-handler/handler-inside.cc
            )
    endif()

    # for all cases
    set(V8_HEADERS_SRC
        include/v8.h
        include/v8config.h
        include/v8-value-serializer-version.h
        include/v8-version-string.h
        include/v8-version.h
    ) # V8_HEADERS_SRC

    # for all cases
    set(V8_LIBBASE_SRC
        src/base/adapters.h
        src/base/atomic-utils.h
        src/base/atomicops.h
        src/base/atomicops_internals_atomicword_compat.h
        src/base/atomicops_internals_portable.h
        src/base/atomicops_internals_std.h
        src/base/base-export.h
        src/base/bits.cc
        src/base/bits.h
        src/base/build_config.h
        src/base/compiler-specific.h
        src/base/cpu.cc
        src/base/cpu.h
        src/base/debug/stack_trace.cc
        src/base/debug/stack_trace.h
        src/base/division-by-constant.cc
        src/base/division-by-constant.h
        src/base/export-template.h
        src/base/file-utils.cc
        src/base/file-utils.h
        src/base/flags.h
        src/base/format-macros.h
        src/base/free_deleter.h
        src/base/functional.cc
        src/base/functional.h
        src/base/hashmap-entry.h
        src/base/hashmap.h
        src/base/ieee754.cc
        src/base/ieee754.h
        src/base/iterator.h
        src/base/lazy-instance.h
        src/base/logging.cc
        src/base/logging.h
        src/base/macros.h
        src/base/once.cc
        src/base/once.h
        src/base/optional.h
        src/base/page-allocator.cc
        src/base/page-allocator.h
        src/base/platform/condition-variable.cc
        src/base/platform/condition-variable.h
        src/base/platform/elapsed-timer.h
        src/base/platform/mutex.cc
        src/base/platform/mutex.h
        src/base/platform/platform.h
        src/base/platform/semaphore.cc
        src/base/platform/semaphore.h
        src/base/platform/time.cc
        src/base/platform/time.h
        src/base/ring-buffer.h
        src/base/safe_conversions.h
        src/base/safe_conversions_impl.h
        src/base/safe_math.h
        src/base/safe_math_impl.h
        src/base/sys-info.cc
        src/base/sys-info.h
        src/base/template-utils.h
        src/base/timezone-cache.h
        src/base/tsan.h
        src/base/utils/random-number-generator.cc
        src/base/utils/random-number-generator.h
    ) # V8_LIBBASE_SRC

    if(UNIX)
        list(APPEND V8_LIBBASE_SRC
            src/base/platform/platform-posix-time.cc
            src/base/platform/platform-posix-time.h
            src/base/platform/platform-posix.cc
            src/base/platform/platform-posix.h
        )
    endif()

    if(APPLE)
        list(APPEND V8_LIBBASE_SRC
            src/base/debug/stack_trace_posix.cc
            src/base/platform/platform-macos.cc
        )
    elseif(LINUX)
        list(APPEND V8_LIBBASE_SRC
            src/base/debug/stack_trace_posix.cc
            src/base/platform/platform-linux.cc
        )
        # TODO add libs: dl rt
        # TODO ldflags += [ "-rdynamic" ] ?
    elseif(WIN32)
        list(APPEND V8_LIBBASE_SRC
            src/base/debug/stack_trace_win.cc
            src/base/platform/platform-win32.cc
            src/base/win32-headers.h
        )
        list(APPEND COMMON_DEFINES}
            -D_CRT_RAND_S
        )
        # TODO add libs:  dbghelp.lib shlwapi.lib winmm.lib ws2_32.lib
        # TODO ldflags += [ "/STACK:2097152" ]
    endif()

    # for all cases
    set(V8_LIBSAMPLER_SRC
        src/libsampler/sampler.cc
        src/libsampler/sampler.h
    ) # V8_LIBSAMPLER_SRC

    # for all cases
    set (INSPECTOR_PROTOCOL
        protocol/Forward.h
        protocol/Protocol.cpp
        protocol/Protocol.h
        protocol/Console.cpp
        protocol/Console.h
        protocol/Debugger.cpp
        protocol/Debugger.h
        protocol/HeapProfiler.cpp
        protocol/HeapProfiler.h
        protocol/Profiler.cpp
        protocol/Profiler.h
        protocol/Runtime.cpp
        protocol/Runtime.h
        protocol/Schema.cpp
        protocol/Schema.h
        ../../include/inspector/Debugger.h
        ../../include/inspector/Runtime.h
        ../../include/inspector/Schema.h
    )

    foreach(file IN LISTS INSPECTOR_PROTOCOL)
        list(APPEND INSPECTOR_PROTOCOL_A ${INSPECTOR_OUT_DIR}/${file})
    endforeach(file)

    add_custom_command(
        OUTPUT ${INSPECTOR_OUT_DIR}/js_protocol.stamp
        COMMAND python ${V8_SRC_DIR}/third_party/inspector_protocol/CheckProtocolCompatibility.py
            --stamp ${INSPECTOR_OUT_DIR}/js_protocol.stamp
            ${V8_SRC_DIR}/src/inspector/js_protocol.json
        DEPENDS ${V8_SRC_DIR}/src/inspector/js_protocol.json
        COMMENT "Checking inspector protocol compatibility"
        VERBATIM
    )
    add_custom_command(
        OUTPUT ${INSPECTOR_PROTOCOL_A}
        COMMAND python ${V8_SRC_DIR}/third_party/inspector_protocol/CodeGenerator.py
            --jinja_dir ${V8_SRC_DIR}/../third_party/
            --output_base ${INSPECTOR_OUT_DIR}
            --config ${V8_SRC_DIR}/src/inspector/inspector_protocol_config.json
        DEPENDS
            ${INSPECTOR_OUT_DIR}/js_protocol.stamp
        WORKING_DIRECTORY ${INSPECTOR_OUT_DIR}
        COMMENT "Generating inspector protocol source code"
        VERBATIM
    )

    add_custom_command(
        OUTPUT ${INSPECTOR_OUT_DIR}/injected-script-source.h
        COMMAND python ${V8_SRC_DIR}/src/inspector/build/xxd.py
            InjectedScriptSource_js
            ${V8_SRC_DIR}/src/inspector/injected-script-source.js
            ${INSPECTOR_OUT_DIR}/injected-script-source.h
        DEPENDS ${V8_SRC_DIR}/src/inspector/injected-script-source.js
        COMMENT "Generating injected script for inspector"
        VERBATIM
    )

    set(INSPECTOR_SRC_A
        ${INSPECTOR_PROTOCOL_A}
        ${INSPECTOR_OUT_DIR}/injected-script-source.h
    )

    foreach(file IN LISTS INSPECTOR_SRC_A)
        set_property(SOURCE ${file} PROPERTY SKIP_AUTOGEN ON)
        set_property(SOURCE ${file} PROPERTY GENERATED ON)
    endforeach(file)

    set(INSPECTOR_SRC
        injected-script.cc
        injected-script.h
        inspected-context.cc
        inspected-context.h
        remote-object-id.cc
        remote-object-id.h
        search-util.cc
        search-util.h
        string-16.cc
        string-16.h
        string-util.cc
        string-util.h
        test-interface.cc
        test-interface.h
        v8-console-agent-impl.cc
        v8-console-agent-impl.h
        v8-console-message.cc
        v8-console-message.h
        v8-console.cc
        v8-console.h
        v8-debugger-agent-impl.cc
        v8-debugger-agent-impl.h
        v8-debugger-script.cc
        v8-debugger-script.h
        v8-debugger.cc
        v8-debugger.h
        v8-function-call.cc
        v8-function-call.h
        v8-heap-profiler-agent-impl.cc
        v8-heap-profiler-agent-impl.h
        v8-injected-script-host.cc
        v8-injected-script-host.h
        v8-inspector-impl.cc
        v8-inspector-impl.h
        v8-inspector-session-impl.cc
        v8-inspector-session-impl.h
        v8-internal-value-type.cc
        v8-internal-value-type.h
        v8-profiler-agent-impl.cc
        v8-profiler-agent-impl.h
        v8-regex.cc
        v8-regex.h
        v8-runtime-agent-impl.cc
        v8-runtime-agent-impl.h
        v8-schema-agent-impl.cc
        v8-schema-agent-impl.h
        v8-stack-trace-impl.cc
        v8-stack-trace-impl.h
        v8-value-utils.cc
        v8-value-utils.h
        wasm-translation.cc
        wasm-translation.h
    )

    foreach(file IN LISTS INSPECTOR_SRC)
        list(APPEND INSPECTOR_SRC_A ${V8_SRC_DIR}/src/inspector/${file})
    endforeach(file)

    # for mksnapshot only
    set(V8_LIBPLATFORM_SRC
        include/libplatform/libplatform-export.h
        include/libplatform/libplatform.h
        include/libplatform/v8-tracing.h
        src/libplatform/default-background-task-runner.cc
        src/libplatform/default-background-task-runner.h
        src/libplatform/default-foreground-task-runner.cc
        src/libplatform/default-foreground-task-runner.h
        src/libplatform/default-platform.cc
        src/libplatform/default-platform.h
        src/libplatform/task-queue.cc
        src/libplatform/task-queue.h
        src/libplatform/tracing/trace-buffer.cc
        src/libplatform/tracing/trace-buffer.h
        src/libplatform/tracing/trace-config.cc
        src/libplatform/tracing/trace-object.cc
        src/libplatform/tracing/trace-writer.cc
        src/libplatform/tracing/trace-writer.h
        src/libplatform/tracing/tracing-controller.cc
        src/libplatform/worker-thread.cc
        src/libplatform/worker-thread.h
    ) # V8_LIBPLATFORM_SRC

    # for mksnapshot, or v8 without snapshot
    set(V8_INITIALIZERS_SRC
        src/builtins/builtins-arguments-gen.cc
        src/builtins/builtins-arguments-gen.h
        src/builtins/builtins-array-gen.cc
        src/builtins/builtins-async-function-gen.cc
        src/builtins/builtins-async-gen.cc
        src/builtins/builtins-async-gen.h
        src/builtins/builtins-async-generator-gen.cc
        src/builtins/builtins-async-iterator-gen.cc
        src/builtins/builtins-boolean-gen.cc
        src/builtins/builtins-call-gen.cc
        src/builtins/builtins-call-gen.h
        src/builtins/builtins-collections-gen.cc
        src/builtins/builtins-console-gen.cc
        src/builtins/builtins-constructor-gen.cc
        src/builtins/builtins-constructor-gen.h
        src/builtins/builtins-constructor.h
        src/builtins/builtins-conversion-gen.cc
        src/builtins/builtins-date-gen.cc
        src/builtins/builtins-debug-gen.cc
        src/builtins/builtins-function-gen.cc
        src/builtins/builtins-generator-gen.cc
        src/builtins/builtins-global-gen.cc
        src/builtins/builtins-handler-gen.cc
        src/builtins/builtins-ic-gen.cc
        src/builtins/builtins-internal-gen.cc
        src/builtins/builtins-interpreter-gen.cc
        src/builtins/builtins-intl-gen.cc
        src/builtins/builtins-iterator-gen.cc
        src/builtins/builtins-iterator-gen.h
        src/builtins/builtins-math-gen.cc
        src/builtins/builtins-math-gen.h
        src/builtins/builtins-number-gen.cc
        src/builtins/builtins-object-gen.cc
        src/builtins/builtins-promise-gen.cc
        src/builtins/builtins-promise-gen.h
        src/builtins/builtins-proxy-gen.cc
        src/builtins/builtins-proxy-gen.h
        src/builtins/builtins-reflect-gen.cc
        src/builtins/builtins-regexp-gen.cc
        src/builtins/builtins-regexp-gen.h
        src/builtins/builtins-sharedarraybuffer-gen.cc
        src/builtins/builtins-string-gen.cc
        src/builtins/builtins-string-gen.h
        src/builtins/builtins-symbol-gen.cc
        src/builtins/builtins-typedarray-gen.cc
        src/builtins/builtins-utils-gen.h
        src/builtins/builtins-wasm-gen.cc
        src/builtins/setup-builtins-internal.cc
        src/heap/setup-heap-internal.cc
        src/ic/accessor-assembler.cc
        src/ic/accessor-assembler.h
        src/ic/binary-op-assembler.cc
        src/ic/binary-op-assembler.h
        src/ic/keyed-store-generic.cc
        src/ic/keyed-store-generic.h
        src/interpreter/interpreter-assembler.cc
        src/interpreter/interpreter-assembler.h
        src/interpreter/interpreter-generator.cc
        src/interpreter/interpreter-generator.h
        src/interpreter/interpreter-intrinsics-generator.cc
        src/interpreter/interpreter-intrinsics-generator.h
        src/interpreter/setup-interpreter-internal.cc
        src/interpreter/setup-interpreter.h
        # x64:
        src/builtins/x64/builtins-x64.cc
    ) # V8_INITIALIZERS_SRC

    # for mksnapshot, or v8 without snapshot
    set(V8_INIT_SRC
        src/setup-isolate-full.cc
    )

    # these will be generated by a python script (js2c)
    set(V8_GENERATED_LIBRARIES
        ${V8_OUT_DIR}/experimental-extras-libraries.cc
        ${V8_OUT_DIR}/extras-libraries.cc
        ${V8_OUT_DIR}/libraries.cc
    ) # V8_GENERATED_LIBRARIES

    # for mksnapshot, or v8 without snapshot
    set(V8_NO_SNAPSHOT_SRC_A # _A means absolute paths
        ${V8_GENERATED_LIBRARIES}
        ${V8_SRC_DIR}/src/snapshot/snapshot-empty.cc
    )

    # for v8 with internal snapshot
    set(V8_SNAPSHOT_SRC_A # _A means absolute paths
        ${V8_GENERATED_LIBRARIES}
        ${V8_OUT_DIR}/snapshot.cc
        ${V8_SRC_DIR}/src/setup-isolate-deserialize.cc
    )

    # for v8 with external snapshot
    set(V8_EXTERNAL_SNAPSHOT_SRC_A # _A means absolute paths
        ${V8_SRC_DIR}/src/setup-isolate-deserialize.cc
        ${V8_SRC_DIR}/src/snapshot/natives-external.cc
        ${V8_SRC_DIR}/src/snapshot/snapshot-external.cc
    )

    # tools/js2c.py libraries.cc CORE ../../v8/src/js/macros.py ../../v8/src/messages.h ../../v8/src/js/prologue.js ../../v8/src/js/array.js ../../v8/src/js/typedarray.js ../../v8/src/js/messages.js ../../v8/src/js/spread.js ../../v8/src/debug/mirrors.js ../../v8/src/debug/debug.js ../../v8/src/debug/liveedit.js ((../../v8/src/js/intl.js)) --startup_blob libraries.bin
    set(js2c_ARGS
        ${V8_SRC_DIR}/src/js/macros.py
        ${V8_SRC_DIR}/src/messages.h
        ${V8_SRC_DIR}/src/js/prologue.js
        ${V8_SRC_DIR}/src/js/array.js
        ${V8_SRC_DIR}/src/js/typedarray.js
        ${V8_SRC_DIR}/src/js/messages.js
        ${V8_SRC_DIR}/src/js/spread.js
        ${V8_SRC_DIR}/src/debug/mirrors.js
        ${V8_SRC_DIR}/src/debug/debug.js
        ${V8_SRC_DIR}/src/debug/liveedit.js
        ${V8_SRC_DIR}/src/js/intl.js
    )
    set (js2c_DEPS ${js2c_ARGS} ${V8_SRC_DIR}/tools/jsmin.py)
    set(js2c_OUT ${V8_OUT_DIR}/libraries.cc)
    set(js2c_CMD
        python ${V8_SRC_DIR}/tools/js2c.py
        ${V8_OUT_DIR}/libraries.cc
        CORE
        ${js2c_ARGS}
    )
    if(V8_USE_EXTERNAL_SNAPSHOT)
        list(APPEND js2c_CMD
            --startup_blob
            ${V8_OUT_DIR}/libraries.bin
        )
        list(APPEND js2c_OUT ${V8_OUT_DIR}/libraries.bin)
    endif(V8_USE_EXTERNAL_SNAPSHOT)
    add_custom_command(
        OUTPUT ${js2c_OUT}
        COMMAND ${js2c_CMD}
        DEPENDS ${js2c_DEPS}
        WORKING_DIRECTORY ${V8_SRC_DIR}
        COMMENT "Generating libraries"
        VERBATIM
    )

    # tools/js2c.py extras-libraries.cc EXTRAS --startup_blob libraries_extras.bin
    set(js2c_extras_DEPS
        ${V8_SRC_DIR}/tools/jsmin.py
    )
    set(js2c_extras_OUT ${V8_OUT_DIR}/extras-libraries.cc)
    set(js2c_extras_CMD
        python "${V8_SRC_DIR}/tools/js2c.py"
        ${V8_OUT_DIR}/extras-libraries.cc
        EXTRAS
    )
    if(V8_USE_EXTERNAL_SNAPSHOT)
        list(APPEND js2c_extras_CMD
            --startup_blob
            ${V8_OUT_DIR}/libraries_extras.bin
        )
        list(APPEND js2c_extras_OUT ${V8_OUT_DIR}/libraries_extras.bin)
    endif(V8_USE_EXTERNAL_SNAPSHOT)
    add_custom_command(
        OUTPUT ${js2c_extras_OUT}
        COMMAND ${js2c_extras_CMD}
        DEPENDS ${js2c_extras_DEPS}
        WORKING_DIRECTORY ${V8_SRC_DIR}
        COMMENT "Generating extras libraries"
        VERBATIM
    )

    # tools/js2c.py experimental-extras-libraries.cc EXPERIMENTAL_EXTRAS --startup_blob libraries_experimental_extras.bin
    set(js2c_experimental_extras_DEPS ${V8_SRC_DIR}/tools/jsmin.py)
    set(js2c_experimental_extras_OUT ${V8_OUT_DIR}/experimental-extras-libraries.cc)
    set(js2c_experimental_extras_CMD
        python ${V8_SRC_DIR}/tools/js2c.py
        ${V8_OUT_DIR}/experimental-extras-libraries.cc
        EXPERIMENTAL_EXTRAS
    )
    if(V8_USE_EXTERNAL_SNAPSHOT)
        list(APPEND js2c_experimental_extras_CMD
            --startup_blob
            ${V8_OUT_DIR}/libraries_experimental_extras.bin
        )
        list(APPEND js2c_experimental_extras_OUT ${V8_OUT_DIR}/libraries_experimental_extras.bin)
    endif(V8_USE_EXTERNAL_SNAPSHOT)
    add_custom_command(
        OUTPUT ${js2c_experimental_extras_OUT}
        COMMAND ${js2c_experimental_extras_CMD}
        DEPENDS ${js2c_experimental_extras_DEPS}
        WORKING_DIRECTORY ${V8_SRC_DIR}
        COMMENT "Generating experimental extras libraries"
        VERBATIM
    )

    if(V8_USE_EXTERNAL_SNAPSHOT)
        # python tools/concatenate-files.py libraries.bin libraries_extras.bin libraries_experimental_extras.bin natives_blob.bin
        set(natives_blob_DEPS
            ${V8_OUT_DIR}/libraries.bin
            ${V8_OUT_DIR}/libraries_extras.bin
            ${V8_OUT_DIR}/libraries_experimental_extras.bin
        ) # natives_blob_DEPS

        add_custom_target(natives_blob
            COMMAND python "${V8_SRC_DIR}/tools/concatenate-files.py"
                ${V8_OUT_DIR}/libraries.bin
                ${V8_OUT_DIR}/libraries_extras.bin
                ${V8_OUT_DIR}/libraries_experimental_extras.bin
                ${V8_OUT_DIR}/natives_blob.bin
            DEPENDS ${natives_blob_DEPS}
            WORKING_DIRECTORY ${V8_SRC_DIR}
            COMMENT "Generating natives_blob.bin"
            VERBATIM
        ) # natives_blob
    endif(V8_USE_EXTERNAL_SNAPSHOT)

    set_property(SOURCE ${V8_OUT_DIR}/experimental-extras-libraries.cc PROPERTY SKIP_AUTOGEN ON)
    set_property(SOURCE ${V8_OUT_DIR}/extras-libraries.cc PROPERTY SKIP_AUTOGEN ON)
    set_property(SOURCE ${V8_OUT_DIR}/libraries.cc PROPERTY SKIP_AUTOGEN ON)

    if(V8_USE_SNAPSHOT)
        set(mksnapshot_SRC ${V8_SRC_DIR}/src/snapshot/mksnapshot.cc)

        # add source files to mksnapshot_SRC, as absolute paths
        foreach(file IN LISTS
            V8_BASE_SRC
            V8_HEADERS_SRC
            V8_LIBBASE_SRC
            V8_LIBSAMPLER_SRC
            V8_LIBPLATFORM_SRC
            V8_INITIALIZERS_SRC
            V8_INIT_SRC
        )
            list(APPEND mksnapshot_SRC ${V8_SRC_DIR}/${file})
        endforeach()

        list(APPEND mksnapshot_SRC
            ${V8_NO_SNAPSHOT_SRC_A}
            ${INSPECTOR_SRC_A}
        )

        set(MKSNAPSHOT_DEFINES
            ${COMMON_DEFINES}
        )

        add_executable(mksnapshot ${mksnapshot_SRC})

        target_link_libraries(mksnapshot PRIVATE ${ICU_UC_LIBRARIES} ${ICU_I18N_LIBRARIES})

        target_include_directories(mksnapshot PRIVATE
            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/pdfium>
            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/pdfium/v8>
            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/pdfium/v8/include>
            ${ICU_INCLUDE_DIRS}
            ${INSPECTOR_OUT_DIR}/../..
        )

        target_compile_definitions(mksnapshot PRIVATE ${MKSNAPSHOT_DEFINES})

        # run_mksnapshot
        # ./mksnapshot --turbo_instruction_scheduling --startup_src snapshot.cc --random-seed 314159265 --startup_blob snapshot_blob.bin
        set(run_mksnapshot_OUT ${V8_OUT_DIR}/snapshot.cc)
        set(run_mksnapshot_CMD
            "${CMAKE_CURRENT_BINARY_DIR}/mksnapshot"
            --turbo_instruction_scheduling
            --startup_src snapshot.cc
            --random-seed 314159265
        )
        if(V8_USE_EXTERNAL_SNAPSHOT)
            list(APPEND run_mksnapshot_CMD --startup_blob snapshot_blob.bin)
            list(APPEND run_mksnapshot_OUT ${V8_OUT_DIR}/snapshot_blob.bin)
        endif(V8_USE_EXTERNAL_SNAPSHOT)
        add_custom_command(
            OUTPUT ${run_mksnapshot_OUT}
            COMMAND ${run_mksnapshot_CMD}
            DEPENDS mksnapshot
            WORKING_DIRECTORY ${V8_OUT_DIR}
            COMMENT "Generating snapshot"
            VERBATIM
        )

        set_property(SOURCE ${V8_OUT_DIR}/snapshot.cc PROPERTY SKIP_AUTOGEN ON)
        set_property(SOURCE ${V8_OUT_DIR}/snapshot.cc PROPERTY GENERATED ON)

    endif(V8_USE_SNAPSHOT)

    # add source files to V8_SRC, as absolute paths
    foreach(file IN LISTS
        V8_MAIN_SRC
        V8_BASE_SRC
        V8_HEADERS_SRC
        V8_LIBBASE_SRC
        V8_LIBSAMPLER_SRC
        V8_LIBPLATFORM_SRC
    )
        list(APPEND V8_SRC ${V8_SRC_DIR}/${file})
    endforeach(file)

    set(V8_DEFINES ${COMMON_DEFINES})

    if (V8_USE_SNAPSHOT)
        if(V8_USE_EXTERNAL_SNAPSHOT)
            list(APPEND V8_SRC ${V8_EXTERNAL_SNAPSHOT_SRC_A})
            list(APPEND V8_DEFINES -DV8_USE_SNAPSHOT -DV8_USE_EXTERNAL_STARTUP_DATA)
        else(V8_USE_EXTERNAL_SNAPSHOT)
            list(APPEND V8_SRC ${V8_SNAPSHOT_SRC_A})
            list(APPEND V8_DEFINES -DV8_USE_SNAPSHOT)
        endif(V8_USE_EXTERNAL_SNAPSHOT)
    else(V8_USE_SNAPSHOT)
        foreach(file IN LISTS
            V8_INITIALIZERS_SRC
            V8_INIT_SRC
        )
            list(APPEND V8_SRC ${V8_SRC_DIR}/${file})
        endforeach(file)
        list(APPEND V8_SRC ${V8_NO_SNAPSHOT_SRC_A})
    endif(V8_USE_SNAPSHOT)
    list(APPEND V8_SRC ${INSPECTOR_SRC_A})

    add_library(v8 ${V8_SRC})
    target_include_directories(v8 PRIVATE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/pdfium>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/pdfium/v8>
        ${ICU_INCLUDE_DIRS}
        ${INSPECTOR_OUT_DIR}/../..
    )
    target_include_directories(v8 PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/pdfium/v8/include>
    )
    target_link_libraries(v8 PRIVATE ${ICU_UC_LIBRARIES} ${ICU_I18N_LIBRARIES})
    target_compile_definitions(v8 PUBLIC ${V8_DEFINES})

    if (V8_USE_SNAPSHOT)
        if(V8_USE_EXTERNAL_SNAPSHOT)
            add_dependencies(v8 natives_blob)
            # With add_custom_command + add_custom_target, mksnapshot is run only when snapshot_blob.bin is missing
            add_custom_target(run_mksnapshot DEPENDS ${V8_OUT_DIR}/snapshot_blob.bin)
            add_dependencies(v8 run_mksnapshot)
        endif(V8_USE_EXTERNAL_SNAPSHOT)
    endif(V8_USE_SNAPSHOT)

    list(APPEND PDFIUM_DEFINES -DPDF_ENABLE_V8)

endif()

add_library(pdfium ${SRC})
target_include_directories(pdfium PRIVATE
    ${ZLIB_INCLUDE_DIRS}
    ${JPEG_INCLUDE_DIR}
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/pdfium>
)
target_include_directories(pdfium PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/pdfium/public>
)
if(ENABLE_V8)
    target_link_libraries(pdfium PRIVATE freetype v8 ${ZLIB_LIBRARIES} ${JPEG_LIBRARIES})
    target_include_directories(pdfium PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/pdfium/v8/include>
    )
else()
    target_link_libraries(pdfium PRIVATE freetype ${ZLIB_LIBRARIES} ${JPEG_LIBRARIES})
endif()

target_compile_definitions(pdfium PUBLIC $<TARGET_PROPERTY:v8,INTERFACE_COMPILE_DEFINITIONS> ${PDFIUM_DEFINES})

# pdfium_test sample
set(PDFIUM_TEST_SRC
    pdfium/testing/fx_string_testhelpers.cpp
    pdfium/testing/fx_string_testhelpers.h
    pdfium/testing/test_support.cpp
    pdfium/testing/test_support.h
    pdfium/testing/utils/path_service.cpp
    pdfium/testing/utils/path_service.h
    pdfium/testing/image_diff/image_diff_png.cpp
    pdfium/testing/image_diff/image_diff_png.h
    pdfium/samples/pdfium_test.cc
    )
add_executable(pdfium_test ${PDFIUM_TEST_SRC})
target_include_directories(pdfium_test PRIVATE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/pdfium>
    )
set (EXTRA_LIBS pdfium ${PNG_LIBRARIES})
if(APPLE)
    find_library(APPKIT AppKit REQUIRED)
    find_library(CORE_FOUNDATION CoreFoundation REQUIRED)
    set (EXTRA_LIBS ${EXTRA_LIBS} ${APPKIT} ${CORE_FOUNDATION})
endif()
target_link_libraries(pdfium_test PRIVATE ${EXTRA_LIBS})
