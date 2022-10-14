<script lang="ts">
	import { onMount } from 'svelte';
	import { env } from '$env/dynamic/public';
	import Jumbotron from '../components/content/Jumbotron.svelte';
	import FormTextInput from '../components/form/FormTextInput.svelte';
	import FormSelectInput from '../components/form/FormSelectInput.svelte';
	import Spinner from '../components/content/Spinner.svelte';

	const fetchClasses = () => {
		fetch(`${env.PUBLIC_BASE_URL}/classes`)
			.then((response) => response.json())
			.then((response) => {
				data.classes = response;
			});
	};

	let data: {
		classes: { id: number; name: string; longname: string }[];
		selectedClass: string;
	} = {
		classes: [],
		selectedClass: ''
	};

	let classUrl = '',
		holidaysUrl = '';

	$: {
		classUrl = data.selectedClass ? `${env.PUBLIC_BASE_URL}/timetables/${data.selectedClass}` : '';
		holidaysUrl = `${env.PUBLIC_BASE_URL}/holidays`;
	}

	onMount(() => fetchClasses());
</script>

<div class="mx-auto container">
	<Jumbotron>
		<div class="text-center">
			<h1 class="font-bold text-4xl mb-2">Generate iCal URL</h1>
			<p>Enter your parameters below to generate your (somewhat) personal iCal URL.</p>
			<p>
				<b>iOS:</b> Open the Calendar app and press 'Calendars' on the bottom of the screen. Press 'Add
				Subscription Calendar' and paste the URL you retrieved below.
			</p>
			<p>
				<b>macOS:</b> Tutorial soon.
			</p>
			<p>
				<b>Android:</b> Tutorial soon.
			</p>
		</div>
		{#if data.classes.length === 0}
			<Spinner />
		{:else}
			<div class="space-y-2 m-2">
				<FormSelectInput label="Select a class" id="classes" bind:value={data.selectedClass}>
					{#each data.classes as klass}
						<option value={klass.id}>{klass.name}</option>
					{/each}
				</FormSelectInput>

				<FormTextInput
					label="Output URL"
					id="url"
					value={classUrl}
					disabled
					readonly
					button
					on:click={() => navigator.clipboard.writeText(classUrl)}>Copy</FormTextInput
				>

				<FormTextInput
					label="Output Holidays URL"
					id="holidays-url"
					value={holidaysUrl}
					disabled
					readonly
					button
					on:click={() => navigator.clipboard.writeText(holidaysUrl)}>Copy</FormTextInput
				>
			</div>
		{/if}
	</Jumbotron>
</div>
