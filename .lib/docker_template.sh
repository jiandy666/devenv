#!/bin/bash


# parse args
for i in "$@"; do
	case $i in
	--name=*)
		_TPL_NAME="${i#*=}"
		shift # past argument=value
		;;
	--start-impl=*)
		_TPL_START_IMPL="${i#*=}"
		shift # past argument=value
		;;
	-*|--*)
		echo "Unknown option $i"
		exit 1
		;;
	*)
		if [ -z _TPL_COMMAND ]; then
			echo too many commands
			exit
		fi
		_TPL_COMMAND=${i};;
	esac
done

# check
if [ -z "$_TPL_NAME" ]; then
	echo docker_template: need setup --name for container name
	exit
fi
if [ -z "$_TPL_START_IMPL" ]; then
	echo "docker_template: need setup --start-impl for start() implementation"
	exit
fi




function start() {
	if [ "$(docker ps -a | grep $_TPL_NAME)" ]; then
		docker start $_TPL_NAME
		return
	fi

	# call start_impl()
	$_TPL_START_IMPL
}

function stop() {
	docker stop $_TPL_NAME
}

function restart() {
	stop
	start
}

function reinit() {
	stop
	docker rm $_TPL_NAME
	start
}

function logs() {
	docker logs $_TPL_NAME -f
}


# run command
case $_TPL_COMMAND in
	start)
		start
		;;
	stop)
		stop
		;;
	restart)
		restart
		;;
	reinit)
		reinit
		;;
	logs)
		logs
		;;
	*)
		echo Unknown command $_TPL_COMMAND
		exit
esac
