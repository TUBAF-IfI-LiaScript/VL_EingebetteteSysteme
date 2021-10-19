import glob, os
import shutil
import re

for file in glob.glob("*.md"):
    if file != "README.md":
        shutil.copy2(file, file+"x")

start = ["``` json @DigiSim.evalJson", "```json @DigiSim.evalJson"]
for file in glob.glob("*.mdx"):
    content = open(file, 'r').readlines()
    filtered = []
    ignoreNextLine = False
    for line in content:
        if any(entry in line for entry in start):
            ignoreNextLine = True
            filtered.append(line)
            continue
        if not ignoreNextLine:
            filtered.append(line)
        else:
            filtered.append("Hier wurde eine animiertes Gattermodell entnommen.\n")
            ignoreNextLine = False

    with open(file, "w") as outfile:
        outfile.write("".join(filtered))

blackList = ["{{", "******", "@Rextester", "@Tau", "@LIA.eval", "[![LiaScript]"]
for file in glob.glob("*.mdx"):
    content = open(file, 'r').readlines()
    filtered = []
    for line in content:
        if any(entry in line for entry in blackList):
            continue
        result = re.search( r'```\S+', line)
        if result:
            line = result.group(0) + "\n"
        filtered.append(line)

    with open(file, "w") as outfile:
        if file.endswith("00_Einfuehrung.mdx"):  # insert metadata for pandoc in first md file
            title = "**Eingebettete Systeme - TU Freiberg**"
            outfile.write(f"---\ntitle: |\n  {title}\n  https://github.com/SebastianZug/VL_EingebetteteSysteme/\nauthor:\n")
            with open(".github/workflows/authors.txt", "r") as authors:  # read in authors and write them into the yaml code
                for line in authors:
                    name = line.strip()
                    outfile.write(f"  - {name}\n")

            outfile.write("papersize:\n  - a4\ngeometry:\n  - margin=2cm\n")
            outfile.write("header-includes:\n  - \\usepackage{titling}\n  - \\pretitle{\\begin{center}\n    \\includegraphics[width=2cm]{images/Logo_TU_Freiberg.png}\\LARGE\\\\}\n  - \\posttitle{\\end{center}}\n---\n")
        outfile.write("".join(filtered))
