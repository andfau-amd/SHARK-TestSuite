module {
  func.func @test_spacetodepth_example(%arg0: !torch.vtensor<[1,1,4,6],f32>) -> !torch.vtensor<[1,4,2,3],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 17 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %0 = torch.operator "onnx.SpaceToDepth"(%arg0) {torch.onnx.blocksize = 2 : si64} : (!torch.vtensor<[1,1,4,6],f32>) -> !torch.vtensor<[1,4,2,3],f32> 
    return %0 : !torch.vtensor<[1,4,2,3],f32>
  }
}

