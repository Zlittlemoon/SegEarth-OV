#!/bin/bash

echo "=== 环境诊断 ==="

echo -e "\n1. Python 版本:"
python --version

echo -e "\n2. PyTorch 信息:"
python -c "
import torch
print(f'PyTorch: {torch.__version__}')
print(f'CUDA available: {torch.cuda.is_available()}')
print(f'CUDA version: {torch.version.cuda}')
print(f'cuDNN version: {torch.backends.cudnn.version()}')
"

echo -e "\n3. CUDA 版本:"
nvcc --version

echo -e "\n4. GPU 信息:"
nvidia-smi --query-gpu=name,driver_version,memory.total --format=csv

echo -e "\n5. mmcv 状态:"
python -c "
try:
    import mmcv
    print(f'✅ mmcv version: {mmcv.__version__}')
    try:
        from mmcv.ops import point_sample
        print('✅ mmcv._ext 可用')
    except Exception as e:
        print(f'❌ mmcv._ext 不可用: {e}')
except Exception as e:
    print(f'❌ mmcv 导入失败: {e}')
"

echo -e "\n6. 相关包版本:"
pip list | grep -E "torch|mmcv|mmseg|opencv"

