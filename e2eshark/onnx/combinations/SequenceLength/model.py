# Copyright 2024 Advanced Micro Devices, Inc.
#
# Licensed under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

# run.py creates runmodel.py by concatenating this file model.py
# and tools/stubs/onnxmodel.py
# Description: testing SequenceConstruct
# See https://onnx.ai/onnx/intro/python.html for intro on creating
# onnx model using python onnx API
import numpy, torch, sys
import onnxruntime
from onnx import numpy_helper, TensorProto, save_model
from onnx.helper import make_model, make_node, make_graph, make_tensor_value_info, make_value_info, make_tensor_sequence_value_info, make_tensor_type_proto
from onnx.checker import check_model

# import from e2eshark/tools to allow running in current dir, for run through
# run.pl, commutils is symbolically linked to allow any rundir to work
sys.path.insert(0, "../../../tools/stubs")
from commonutils import E2ESHARK_CHECK_DEF

# Create an instance of it for this test
E2ESHARK_CHECK = dict(E2ESHARK_CHECK_DEF)


# Create an input (ValueInfoProto)
X = make_tensor_value_info("X", TensorProto.FLOAT, [5, 4])
Y = make_tensor_value_info("Y", TensorProto.FLOAT, [5, 4])

# Create an output
X2 = make_tensor_sequence_value_info("X2", TensorProto.FLOAT, None)

Z = make_value_info("Z", make_tensor_type_proto(TensorProto.INT64, []))

# Create a node (NodeProto)
sequence_construct_node = make_node(
    "SequenceConstruct", ["X", "Y"], ["X2"], "sequence_construct_node"  # node name  # inputs  # outputs
)

sequence_length_node = make_node(
    "SequenceLength", ["X2"], ["Z"], "sequence_length_node"
)

# Create the graph (GraphProto)
graph = make_graph(
    [sequence_construct_node, sequence_length_node],
    "sequence_length_graph",
    [X, Y],
    [Z],
)

# Create the model (ModelProto)
onnx_model = make_model(graph)
onnx_model.opset_import[0].version = 19

# Save the model
# save_model(onnx_model, "model.onnx")
with open("model.onnx", "wb") as f:
    f.write(onnx_model.SerializeToString())


session = onnxruntime.InferenceSession("model.onnx", None)
model_input_X = numpy.random.randn(5, 4).astype(numpy.float32)
model_input_Y = numpy.random.randn(5, 4).astype(numpy.float32)
# gets X in inputs[0] and Y in inputs[1]
inputs = session.get_inputs()
# gets Z in outputs[0]
outputs = session.get_outputs()

model_output = session.run(
    [outputs[0].name],
    {inputs[0].name: model_input_X, inputs[1].name: model_input_Y},
)

# Moving to torch to handle bfloat16 as numpy does not support bfloat16
E2ESHARK_CHECK["input"] = [
    torch.from_numpy(model_input_X),
    torch.from_numpy(model_input_Y),
]
E2ESHARK_CHECK["output"] = [torch.from_numpy(x) for x in model_output]

print("Input:", E2ESHARK_CHECK["input"])
print("Output:", E2ESHARK_CHECK["output"])
