import os
import random
import string
import argparse
import shutil
from pathlib import Path


def generate_model_name(index):
    """Generate model names in sequence: aaa, aab, aac, ..., zzz"""
    letters = string.ascii_lowercase
    # Total combinations possible: 26^3 = 17,576
    if index >= 26**3:
        raise ValueError(f"Index {index} exceeds maximum possible model names (17,576)")

    l1 = letters[index // (26 * 26)]
    l2 = letters[(index // 26) % 26]
    l3 = letters[index % 26]
    return f"model_{l1}{l2}{l3}"


def create_model_content(refs=None):
    """Create the SQL content for a model"""
    if not refs:
        return "select 42 as answer"

    # Join multiple refs with union all for models that reference multiple upstream models
    if len(refs) > 1:
        ref_queries = []
        for ref in refs:
            ref_queries.append(f"select answer from {{{{ ref('{ref}') }}}}")
        return " union all ".join(ref_queries)
    else:
        return f"select answer from {{{{ ref('{refs[0]}') }}}}"


def generate_dbt_models(models_path, layers_num, models_num):
    """Generate dbt models with specified parameters"""
    shutil.rmtree(models_path, ignore_errors=True)
    Path(models_path).mkdir(parents=True, exist_ok=True)

    # Calculate models per layer
    models_per_layer = [0] * layers_num
    remaining = models_num

    # Distribute models across layers
    for i in range(layers_num):
        if i == 0:
            # First layer should have at least 2 models for A and B
            models_per_layer[i] = max(2, models_num // layers_num)
        else:
            # Other layers get approximately equal distribution
            models_per_layer[i] = max(1, models_num // layers_num)

        remaining -= models_per_layer[i]

    # Distribute any remaining models to middle layers for more complexity
    middle_layers = list(range(1, layers_num - 1)) if layers_num > 2 else [0]
    while remaining > 0:
        for layer in middle_layers:
            if remaining > 0:
                models_per_layer[layer] += 1
                remaining -= 1

    # Generate models
    model_names = []
    model_index = 0

    for layer in range(layers_num):
        # Create directory for this layer
        layer_dir = os.path.join(models_path, f"layer_{layer+1:02d}")
        Path(layer_dir).mkdir(exist_ok=True)

        layer_models = []

        # Generate models for this layer
        for _ in range(models_per_layer[layer]):
            model_name = generate_model_name(model_index)
            model_index += 1

            # First layer models have no dependencies
            if layer == 0:
                content = create_model_content()
            else:
                # Select 1-3 random models from previous layer
                prev_layer_models = model_names[-models_per_layer[layer - 1] :]
                num_refs = min(random.randint(1, 3), len(prev_layer_models))
                refs = random.sample(prev_layer_models, num_refs)
                content = create_model_content(refs)

            # Write model file
            model_path = os.path.join(layer_dir, f"{model_name}.sql")
            with open(model_path, "w") as f:
                f.write(content)

            layer_models.append(model_name)
            model_names.append(model_name)

        print(f"Layer {layer+1}: {len(layer_models)} models")

    print(f"\nGenerated {len(model_names)} models across {layers_num} layers")

    # Report on the example models A, B, C, D, E if they exist
    if models_num >= 5:
        print("\nExample models:")
        print(f"A: {model_names[0]}.sql")
        print(f"B: {model_names[1]}.sql")
        if layers_num >= 2:
            print(
                f"C: {model_names[models_per_layer[0]]}.sql (references {model_names[0]})"
            )
            print(
                f"D: {model_names[models_per_layer[0]+1]}.sql (references {model_names[1]})"
            )
        if layers_num >= 3 and models_per_layer[1] >= 2:
            print(
                f"E: {model_names[models_per_layer[0]+models_per_layer[1]]}.sql (references {model_names[models_per_layer[0]]} and {model_names[models_per_layer[0]+1]})"
            )


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Generate DBT models with configurable lineage"
    )
    parser.add_argument(
        "--layers_num", type=int, default=3, help="Number of dependency layers"
    )
    parser.add_argument(
        "--models_num", type=int, default=5, help="Total number of models to generate"
    )

    args = parser.parse_args()

    generate_dbt_models("./models/3_dummy", args.layers_num, args.models_num)
