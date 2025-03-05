# this script generates binary trie representations in xml format for draw.io
# the generated xml files can be imported into draw.io in "Extras" -> "Edit Diagram..."
# the trie can be edited in draw.io and exported as png or svg

from binary_trie import Trie, int_to_bitstring, bitstring_to_int
import random

cellWidth = 100
deltaX = 40
cellHeight = 30
deltaY = 5

# for horizontal trie representation
cellStyle = "rounded=1;fontSize=20;fontStyle=1;labelBackgroundColor=none;fillColor=none;fontColor=#FFFFFF;strokeColor=#FFFFFF;strokeWidth=2;"
linkStyle = "endArrow=classic;html=1;rounded=0;labelBackgroundColor=none;strokeColor=#FFFFFF;strokeWidth=2;fontSize=20;fontColor=#FFFFFF;exitX=1;exitY=0.5;exitDx=0;exitDy=0;entryX=0;entryY=0.5;entryDx=0;entryDy=0;"

start = """<mxGraphModel dx="0" dy="0" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1000" pageHeight="1000" math="0" shadow="0">
  <root>
    <mxCell id="0" />
    <mxCell id="1" parent="0" />
"""
end = """  </root>
</mxGraphModel>
"""


def addCell(key, xpos, ypos):
    width = cellWidth
    return """    <mxCell id="-c{}" value="{}" style="{}" vertex="1" parent="1">
      <mxGeometry x="{}" y="{}" width="{}" height="{}" as="geometry" />
    </mxCell>
""".format(
        key, key, cellStyle, xpos, ypos, width, cellHeight
    )


def addLink(key0, key1):
    return """    <mxCell id="-l{}-{}" value="" style="{}" vertex="1" parent="1" source="-c{}" target="-c{}" edge="1">
      <mxGeometry width="50" height="50" relative="1" as="geometry" />
    </mxCell>
""".format(
        key0, key1, linkStyle, key0, key1
    )


def gen_drawio(trie, filename):
    cellsCoords = {}
    links = []

    # add leaves
    leaves = trie.match_prefix_keys(prefix="")
    keylen = len(leaves[0])
    for i in range(len(leaves)):
        cellsCoords[leaves[i]] = (
            keylen * (cellWidth + deltaX),
            i * (cellHeight + deltaY),
        )

    # add middle nodes
    for depth in range(keylen - 1, 0, -1):
        for i in range(2**depth):
            bs = int_to_bitstring(i, depth)
            if trie.contains(bs):
                parent = trie.find_trie(bs)
                child0 = parent.branch[0].key
                child1 = parent.branch[1].key

                # y position is the average of the children
                y = (cellsCoords[child0][1] + cellsCoords[child1][1]) / 2
                # x position is the depth of the node
                cellsCoords[bs] = (depth * (cellWidth + deltaX), y)

                # add links
                links.append((bs, child0))
                links.append((bs, child1))

    # add root and links to root
    cellsCoords["."] = (0, (cellsCoords["0"][1] + cellsCoords["1"][1]) / 2)
    links.append((".", "0"))
    links.append((".", "1"))

    # generate xml
    text = start
    for key in cellsCoords:
        text += addCell(key, cellsCoords[key][0], cellsCoords[key][1])
    for link in links:
        text += addLink(link[0], link[1])
    text += end

    # write to file
    f = open(filename + ".xml", "w")
    f.write(text)
    f.close()


def gen_compressed_drawio(trie, filename):
    cellsCoords = {}
    links = []

    leaves = trie.match_prefix_keys(prefix="")
    keylen = len(leaves[0])

    # find max depth
    maxDepth = 0
    for n in trie.match_prefix_tries(prefix=""):
        if n.dpt > maxDepth:
            maxDepth = n.dpt

    # add leaves
    for i in range(len(leaves)):
        cellsCoords[leaves[i]] = (
            maxDepth * (cellWidth + deltaX),
            i * (cellHeight + deltaY),
        )

    # add middle nodes
    for depth in range(keylen - 1, 0, -1):
        for i in range(2**depth):
            bs = int_to_bitstring(i, depth)
            if trie.contains(bs):
                parent = trie.find_trie(bs)
                child0 = parent.branch[0].key
                child1 = parent.branch[1].key

                y = (cellsCoords[child0][1] + cellsCoords[child1][1]) / 2
                cellsCoords[bs] = (parent.dpt * (cellWidth + deltaX), y)

                links.append((bs, child0))
                links.append((bs, child1))

    # add root and links to root
    cellsCoords["."] = (0, (cellsCoords["0"][1] + cellsCoords["1"][1]) / 2)
    links.append((".", "0"))
    links.append((".", "1"))

    # generate xml
    text = start
    for key in cellsCoords:
        text += addCell(key, cellsCoords[key][0], cellsCoords[key][1])
    for link in links:
        text += addLink(link[0], link[1])
    text += end

    # write to file
    f = open(filename + ".xml", "w")
    f.write(text)
    f.close()


# generate random trie, with n keys of length keylen
def random_trie(keylen, n):
    trie = Trie()
    keys = set()
    while len(keys) < n:
        keys.add(random.randint(0, 2**keylen - 1))
    for i in list(keys):
        trie.add(int_to_bitstring(i, keylen))
    return trie



gen_compressed_drawio(random_trie(8, 24), "trie")

