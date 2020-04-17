EXEC := caverage.awk

all: dat
	$(EXEC) dat

run:
	$(EXEC) dat
	dum.awk dat
	cat caverage.out

clean:
	$(RM) caverage.out
