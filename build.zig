const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "yuv",
        .root_source_file = b.addWriteFiles().add("empty.c", ""),
        .target = target,
        .optimize = optimize,
    });

    lib.linkLibCpp();
    lib.addIncludePath(.{ .path = "include" });
    lib.addCSourceFiles(&[_][]const u8{
        "source/compare.cc",
        "source/compare_common.cc",
        "source/compare_gcc.cc",
        "source/compare_msa.cc",
        "source/compare_win.cc",
        "source/convert_argb.cc",
        "source/convert.cc",
        "source/convert_from_argb.cc",
        "source/convert_from.cc",
        "source/convert_jpeg.cc",
        "source/convert_to_argb.cc",
        "source/convert_to_i420.cc",
        "source/cpu_id.cc",
        "source/mjpeg_decoder.cc",
        "source/mjpeg_validate.cc",
        "source/planar_functions.cc",
        "source/rotate_any.cc",
        "source/rotate_argb.cc",
        "source/rotate.cc",
        "source/rotate_common.cc",
        "source/rotate_gcc.cc",
        "source/rotate_lsx.cc",
        "source/rotate_msa.cc",
        "source/rotate_win.cc",
        "source/row_any.cc",
        "source/row_common.cc",
        "source/row_gcc.cc",
        "source/row_lasx.cc",
        "source/row_lsx.cc",
        "source/row_msa.cc",
        "source/row_rvv.cc",
        "source/row_win.cc",
        "source/scale_any.cc",
        "source/scale_argb.cc",
        "source/scale.cc",
        "source/scale_common.cc",
        "source/scale_gcc.cc",
        "source/scale_lsx.cc",
        "source/scale_msa.cc",
        "source/scale_rgb.cc",
        "source/scale_rvv.cc",
        "source/scale_uv.cc",
        "source/scale_win.cc",
        "source/video_common.cc",
    }, &[_][]const u8{});

    // contains only GLX headers!
    lib.installHeadersDirectory("./include/libyuv", "libyuv/");
    lib.installHeader("./include/libyuv.h", "libyuv.h");

    b.installArtifact(lib);
}
