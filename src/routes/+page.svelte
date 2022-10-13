<script lang="ts">
	import { onMount } from 'svelte';
	import { env } from '$env/dynamic/public';
	import Jumbotron from '../components/content/Jumbotron.svelte';
	import FormTextInput from '../components/form/FormTextInput.svelte';
	import FormSelectInput from '../components/form/FormSelectInput.svelte';
	import Button from '../components/action/Button.svelte';

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
			<svg
				aria-hidden="true"
				class="mr-2 w-8 h-8 text-gray-200 animate-spin dark:text-gray-600 fill-blue-600"
				viewBox="0 0 100 101"
				fill="none"
				xmlns="http://www.w3.org/2000/svg"
				><path
					d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
					fill="currentColor"
				/>
				<path
					d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"
					fill="currentFill"
				/></svg
			>
		{:else}
			<div class="space-y-2 m-2">
				<FormSelectInput label="Select a class" id="classes" bind:value={data.selectedClass}>
					{#each data.classes as klass}
						<option value={klass.id}>{klass.name}</option>
					{/each}
				</FormSelectInput>

				<FormTextInput label="Output URL" id="url" value={classUrl} disabled readonly />
				<Button on:click={() => navigator.clipboard.writeText(classUrl)}>Copy</Button>

				<FormTextInput
					label="Output Holidays URL"
					id="holidays-url"
					value={holidaysUrl}
					disabled
					readonly
				/>
				<Button on:click={() => navigator.clipboard.writeText(holidaysUrl)}>Copy</Button>
			</div>
		{/if}
	</Jumbotron>
</div>
