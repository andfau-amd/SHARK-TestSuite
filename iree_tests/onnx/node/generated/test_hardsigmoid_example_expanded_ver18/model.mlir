module {
  func.func public @test_hardsigmoid_example_expanded_ver18(%arg0: !torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %0 = torch.operator "onnx.Constant"() {torch.onnx.value_float = 5.000000e-01 : f32} : () -> !torch.vtensor<[],f32> 
    %1 = torch.operator "onnx.CastLike"(%0, %arg0) : (!torch.vtensor<[],f32>, !torch.vtensor<[3],f32>) -> !torch.vtensor<[],f32> 
    %2 = torch.operator "onnx.Constant"() {torch.onnx.value_float = 6.000000e-01 : f32} : () -> !torch.vtensor<[],f32> 
    %3 = torch.operator "onnx.CastLike"(%2, %arg0) : (!torch.vtensor<[],f32>, !torch.vtensor<[3],f32>) -> !torch.vtensor<[],f32> 
    %4 = torch.operator "onnx.Constant"() {torch.onnx.value = dense<0.000000e+00> : tensor<f32>} : () -> !torch.vtensor<[],f32> 
    %5 = torch.operator "onnx.CastLike"(%4, %arg0) : (!torch.vtensor<[],f32>, !torch.vtensor<[3],f32>) -> !torch.vtensor<[],f32> 
    %6 = torch.operator "onnx.Constant"() {torch.onnx.value = dense<1.000000e+00> : tensor<f32>} : () -> !torch.vtensor<[],f32> 
    %7 = torch.operator "onnx.CastLike"(%6, %arg0) : (!torch.vtensor<[],f32>, !torch.vtensor<[3],f32>) -> !torch.vtensor<[],f32> 
    %8 = torch.operator "onnx.Mul"(%arg0, %1) : (!torch.vtensor<[3],f32>, !torch.vtensor<[],f32>) -> !torch.vtensor<[3],f32> 
    %9 = torch.operator "onnx.Add"(%8, %3) : (!torch.vtensor<[3],f32>, !torch.vtensor<[],f32>) -> !torch.vtensor<[3],f32> 
    %10 = torch.operator "onnx.Min"(%9, %7) : (!torch.vtensor<[3],f32>, !torch.vtensor<[],f32>) -> !torch.vtensor<[3],f32> 
    %11 = torch.operator "onnx.Max"(%10, %5) : (!torch.vtensor<[3],f32>, !torch.vtensor<[],f32>) -> !torch.vtensor<[3],f32> 
    return %11 : !torch.vtensor<[3],f32>
  }
}

