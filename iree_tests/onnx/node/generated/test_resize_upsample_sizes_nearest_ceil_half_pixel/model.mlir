module {
  func.func @test_resize_upsample_sizes_nearest_ceil_half_pixel(%arg0: !torch.vtensor<[1,1,4,4],f32>, %arg1: !torch.vtensor<[4],si64>) -> !torch.vtensor<[1,1,8,8],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 19 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %0 = torch.operator "onnx.Resize"(%arg0, %none, %none, %arg1) {torch.onnx.coordinate_transformation_mode = "half_pixel", torch.onnx.mode = "nearest", torch.onnx.nearest_mode = "ceil"} : (!torch.vtensor<[1,1,4,4],f32>, !torch.none, !torch.none, !torch.vtensor<[4],si64>) -> !torch.vtensor<[1,1,8,8],f32> 
    return %0 : !torch.vtensor<[1,1,8,8],f32>
  }
}

