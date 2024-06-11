module {
  func.func @test_string_split_empty_string_delimiter(%arg0: !torch.vtensor<[3],!torch.str>) -> (!torch.vtensor<[3,3],!torch.str>, !torch.vtensor<[3],si64>) attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %0:2 = torch.operator "onnx.StringSplit"(%arg0) {torch.onnx.delimiter = ""} : (!torch.vtensor<[3],!torch.str>) -> (!torch.vtensor<[3,3],!torch.str>, !torch.vtensor<[3],si64>) 
    return %0#0, %0#1 : !torch.vtensor<[3,3],!torch.str>, !torch.vtensor<[3],si64>
  }
}

