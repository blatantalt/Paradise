import { Flex } from '../../../tgui/packages/tgui/components';
import { useBackend } from  '../../../tgui/packages/tgui/backend';
import { Button, LabeledList, Section } from '../../../tgui/packages/tgui/components';
import { Window } from '../../../tgui/packages/tgui/layouts';

export const MemoryInterface = (props, context) => {
	const {act, data} = useBackend(context);
	//extract "health" and "color" variables from the data object
	const {
		selected,
		memories,
		thisMemory,
	} = data;
	return(
		<Window resizable>
			<Window.Content scrollable>
				<Flex direction="row">
					<Comment This is the main flexbox/>
					<Flex.Item>
						<Comment The memory list pane/>
						<Section title="Memories">
							<Flex direction="column">
								{memories.map(item => {
									<Button
										content={item.title}
										textAlign="center"
										onClick = {() => act('selMem',{
											'index': item.index,})} />
								})}
							</Flex>
						</Section>
					</Flex.Item>
					<Flex.Item>
						<Comment The detail pane/>
						<DetailPane/>
					</Flex.Item>
				</Flex>
			</Window.Content>
		</Window>
	);
};

const DetailPane = (props, context) => {
	const {act, data} = useBackend(context);
	const {
		selected,
		memories,
		thisMemory,
	} = data;
	return (
		<Box>
			{selected == 0 && (
				<Box textAlign = "center">"Please select a memory."</Box>
			) || (
				<Section title = {thisMemory.title}>
					<Flex direction="column">
						<Flex.Item>
							<Box>{thisMemory.description}</Box>
						</Flex.Item>
						<Flex.Item grow={1}/>
						<Flex.Item>
							<Flex direction = "row">
								<Flex.Item>
									Memory Depth: {thisMemory.depth}
								</Flex.Item>
								<Flex.Item>
									Memory Stability: {thisMemory.difficulty}
								</Flex.Item>
							</Flex>
						</Flex.Item>
						<Flex.Item>
							This Memory's uEffect value is {thisMemory.uEffect}.
							This will later be updated to have descriptive text.
						</Flex.Item>
						<FlexItem>
							This is where the memory tampering notifications will go, when that's implemented.
						</FlexItem>
					</Flex>
				</Section>
			)}
		</Box>
	)

};
