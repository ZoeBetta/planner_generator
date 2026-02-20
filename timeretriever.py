import os
import re
import pandas as pd

folder_path = "/home/linuxbrew/planner/outputs"

results = []

for filename in os.listdir(folder_path):
    if filename.endswith(".txt"):
        file_path = os.path.join(folder_path, filename)

        with open(file_path, "r", encoding="utf-8") as f:
            content = f.read()

        # -------- Extract Time --------
        time_match = re.search(r"; Time\s+([0-9.]+)", content)
        time_value = float(time_match.group(1)) if time_match else 300.0
        unsolvable = False
        if "The goal fact:" in content:
            time_value = 300.0  # in questo caso sono in unsolvable senza pruning
            unsolvable = True
        

        # -------- Count Actions --------
        # Matches lines like:
        # 0.000: (checklink spot r11f1 r01f1)  [5.000]
        action_lines = re.findall(r"^\d+\.\d+:\s+\(", content, re.MULTILINE)
        num_actions = len(action_lines)
        if not unsolvable:
            if num_actions == 0 and not time_match:
                time_value = 500  # in questo caso sono in timeout. il file non ha azioni e non ho trovato il tempo
            elif num_actions == 0:
                time_value = 300  # in questo caso sono in unsolvable col pruning

        results.append({
            "Filename": filename,
            "Time": time_value,
            "Number_of_Actions": num_actions
        })

# Create dataframe
df = pd.DataFrame(results)

# Save to Excel
df.to_excel("combined_results_prov.xlsx", index=False)

print("Done! Excel file created.")
