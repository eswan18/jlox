BUILD_DIR := build

DIR := java
PACKAGE := lox
SOURCES := $(wildcard $(DIR)/com/craftinginterpreters/$(PACKAGE)/*.java)
CLASSES := $(addprefix $(BUILD_DIR)/, $(SOURCES:.java=.class))

TOOL_PKG := tool
TOOL_SRCS := $(wildcard $(DIR)/com/craftinginterpreters/$(TOOL_PKG)/*.java)
TOOL_CLS := $(addprefix $(BUILD_DIR)/, $(TOOL_SRCS:.java=.class))
	
JAVA_OPTIONS := -Werror

default: $(CLASSES)
	@:

$(BUILD_DIR)/$(DIR)/%.class: $(DIR)/%.java
	mkdir -p $(BUILD_DIR)/$(DIR)
	javac -cp $(DIR) -d $(BUILD_DIR)/$(DIR) $(JAVA_OPTIONS) -implicit:none $<
	@ printf "%8s %-60s %s\n" javac $< "$(JAVA_OPTIONS)"

tool: $(TOOL_CLS)
	@:

ast: tool
	java -cp build/java com.craftinginterpreters.tool.GenerateAst ./java/com/craftinginterpreters/lox/

clean:
	rm -rf build/
