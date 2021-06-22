import { useBackend } from  '../backend';
import { Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const SampleInterface = (props, context) => {
	const {act, data} = useBackend(context);
	//extract "health" and "color" variables from the data object
	const {
		health,
		color,
	} = data;
	return(
		<Window resizable>
			<Window.Content scrollable>
				<Comment> TODO: MAKE IT USE FLEX, NOT TABLE.</Comment>

				<Table>
					<Table.Row>
						<Table.Cell bold>
							"MEMORY LIST :D"
						</Table.Cell>
						<Table.Cell bold>
							MEMORY INFORMATION
						</Table.Cell>
					</Table.Row>
				</Table>
			</Window.Content>
		</Window>
		/*
		<Window resizable>
			<Window.Content scrollable>
				<LabeledList>
					<LabeledList.Item label="Health">
						{health}
					</LabeledList.Item>
					<LabeledList.Item label="Color">
						{color}
					</LabeledList.Item>
					<LabeledList.Item label="Button">
						<Button
							content = "Dispatch a test action"
							onClick = {() => act('test')} />
					</LabeledList.Item>
				</LabeledList>
			</Window.Content>
		</Window>
		*/
	);
};
