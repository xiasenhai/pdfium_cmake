#!/bin/bash

cd ../pdfium
ninja -C out/Debug pdfium_all && out/Debug/pdfium_embeddertests --gtest_break_on_failure \
  && ASAN_OPTIONS=allocator_may_return_null=1 out/Debug/pdfium_unittests --gtest_break_on_failure

