

## Installation

Create a virtual environment with Python 3.11.

To install the required dependencies, run the following command:

```bash
pip install -r requirements.txt
```

## Dataset

The dataset is located in the `vlm/vlm_dataset` folder (JSON splits). Image data should be placed under the repo’s `data/` directory:

```
vlm
├── vlm_dataset
│   ├── vlm_baseline_test.json       # Baseline test set
│   ├── vlm_baseline_trainval.json   # Baseline training and validation set
│   ├── vlm_reasoning_test.json      # Reasoning test set
│   ├── vlm_reasoning_trainval.json  # Reasoning training and validation set
```

Image files are under the repo’s `data/` directory. Before training or inference, ensure that the image paths in the dataset JSONs point to these files (e.g. under `data/`).

## Training or Testing

Submit the training or testing scripts using the `sbatch` command:

```bash
sbatch submit_job.sh
```

## Evaluation

The evaluation results include the accuracy (ACC) metric with confidence intervals calculated using 1000 resampling iterations.

The evaluation code can be found in the Jupyter notebook:

```
vlm/notebook/1_evaluate.ipynb
```

## Style transfer

The style transfer code can be found in the Jupyter notebook:

```
vlm/notebook/2_style_transfer.ipynb
```